#!/usr/bin/env python3
import argparse
import curses
import re
import shutil
import subprocess
import sys
import unicodedata

HEADERS = ("CHAR", "CODE POINT", "ESCAPE", "ENTITY", "NAME")


def search(pattern, count):
    rows = []
    for codeptx in range(0x20000):
        if count is not None and len(rows) >= count:
            break
        try:
            c = chr(codeptx)
            n = unicodedata.name(c)
        except ValueError:
            continue
        cat = unicodedata.category(c)
        row = (c, f"U+{codeptx:04X}", f"\\u{codeptx:04X}", f"&#{codeptx:04};", n)
        if not pattern or pattern.search("\t".join(row)):
            rows.append(row)
    return rows


def copy(text):
    commands = (
        ["pbcopy"],
        ["wl-copy"],
        ["xclip", "-selection", "clipboard"],
        ["xsel", "--clipboard", "--input"],
    )
    cmd = next((c for c in commands if shutil.which(c[0])), None)
    if not cmd:
        return "no clipboard tool found (pbcopy, wl-copy, xclip, xsel)"
    try:
        subprocess.run(cmd, input=text.encode(), check=True)
    except subprocess.CalledProcessError as e:
        return f"{cmd[0]} failed with exit code {e.returncode}"
    return None


def width(text):
    total = 0
    for c in text:
        if unicodedata.combining(c):
            continue
        total += 2 if unicodedata.east_asian_width(c) in "WF" else 1
    return total


def pad(text, to):
    return text + " " * max(0, to - width(text))


def put(win, y, x, text, attr):
    maxy, maxx = win.getmaxyx()
    if y >= maxy or x >= maxx:
        return
    try:
        win.addnstr(y, x, text, maxx - x - 1, attr)
    except curses.error:  # writing into the last cell of the screen
        pass


def draw(win, rows, widths, row, col, status):
    win.erase()
    maxy, maxx = win.getmaxyx()
    body = maxy - 2
    top = max(0, min(row - body + 1, len(rows) - body)) if len(rows) > body else 0

    x = 0
    for i, header in enumerate(HEADERS):
        put(win, 0, x, pad(header, widths[i]), curses.A_BOLD)
        x += widths[i] + 1

    for y, r in enumerate(rows[top : top + body]):
        x = 0
        for i, cell in enumerate(r):
            attr = curses.A_REVERSE if top + y == row and i == col else curses.A_NORMAL
            put(win, y + 1, x, pad(cell, widths[i]), attr)
            x += widths[i] + 1

    put(win, maxy - 1, 0, pad(status, maxx), curses.A_DIM)
    win.refresh()


def tui(stdscr, rows):
    curses.curs_set(0)
    widths = [max(width(r[i]) for r in rows + [HEADERS]) for i in range(len(HEADERS))]
    row, col = 0, 0
    status = None
    while True:
        hint = f"[{row + 1}/{len(rows)}] arrows/hjkl move, enter copies cell, q quits"
        status = status or hint
        draw(stdscr, rows, widths, row, col, status)
        key = stdscr.getch()
        status = None
        if key in (curses.KEY_DOWN, ord("j")):
            row = min(row + 1, len(rows) - 1)
        elif key in (curses.KEY_UP, ord("k")):
            row = max(row - 1, 0)
        elif key in (curses.KEY_RIGHT, ord("l")):
            col = min(col + 1, len(HEADERS) - 1)
        elif key in (curses.KEY_LEFT, ord("h")):
            col = max(col - 1, 0)
        elif key in (curses.KEY_HOME, ord("g")):
            row = 0
        elif key in (curses.KEY_END, ord("G")):
            row = len(rows) - 1
        elif key in (curses.KEY_ENTER, 10, 13, ord(" ")):
            cell = rows[row][col]
            error = copy(cell)
            status = f"copy failed: {error}" if error else f"copied {cell!r} to clipboard"
        elif key in (ord("q"), 27):
            return


parser = argparse.ArgumentParser(
    description="Search Unicode characters by name and print them "
    "as code point, escape sequence, HTML entity, character and name."
)
parser.add_argument(
    "pattern",
    nargs="?",
    help="regular expression to filter the output lines (case-insensitive)",
)
parser.add_argument(
    "-n",
    "--count",
    type=int,
    help="maximum number of characters (default: 20 when printing, all in the selector)",
)
parser.add_argument(
    "-p",
    "--plain",
    action="store_true",
    help="print the results instead of starting the interactive selector",
)
args = parser.parse_args()

plain = args.plain or not (sys.stdin.isatty() and sys.stdout.isatty())
count = args.count if args.count is not None else (20 if plain else None)
rows = search(re.compile(args.pattern, re.IGNORECASE) if args.pattern else None, count)

if not rows:
    sys.exit("no matching characters")
if plain:
    for row in rows:
        print(f"{row[0]:>4}\t{row[1]}\t{row[2]}\t{row[3]}  \t{row[4]:<60}")
else:
    curses.wrapper(tui, rows)
