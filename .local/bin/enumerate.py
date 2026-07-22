#!/usr/bin/env python3
"""enumerate — run a command over a source of items, or just list them."""

import argparse
import glob
import shlex
import subprocess
import sys
from typing import Optional


class Args(argparse.Namespace):
    """Typed view of the parsed arguments (exactly one source is non-None)."""

    pattern: Optional[str]  # -f glob pattern
    lines_file: Optional[str]  # -l file (or '-' for stdin)
    num_range: Optional[list[int]]  # -r [start, end]
    items: Optional[list[str]]  # -L items
    command: Optional[str]  # trailing shell command


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="enumerate",
        description="Run a command over a source of items, or just list them.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "COMMAND is a single shell command string; the {} token in it is\n"
            "replaced (shell-quoted) with each item. With no command, items are\n"
            "printed one per line so you can pipe them.\n\n"
            "examples:\n"
            "  enumerate --files '*.sh' 'wc -l {}'\n"
            "  enumerate --lines /etc/hosts 'echo {}'\n"
            "  enumerate --range 1 10 'printf \"n=%d\\n\" {}'\n"
            "  enumerate --list a b c 'echo item: {}'\n"
            "  enumerate --files '*.log' | xargs rm\n"
            '  cat urls.txt | enumerate --lines - | while read url; do curl -s "$url"; done'
        ),
    )
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument(
        "-f", "--files", dest="pattern", metavar="PATTERN", help="files matching a glob"
    )
    source.add_argument(
        "-l",
        "--lines",
        dest="lines_file",
        metavar="FILE",
        help="lines of a file ('-' = stdin)",
    )
    source.add_argument(
        "-r",
        "--range",
        dest="num_range",
        nargs=2,
        type=int,
        metavar=("START", "END"),
        help="an inclusive integer range",
    )
    source.add_argument(
        "-L",
        "--list",
        dest="items",
        nargs="+",
        metavar="ITEM",
        help="a literal list of items",
    )
    parser.add_argument(
        "command",
        nargs="?",
        help="shell command to run per item; {} is the placeholder",
    )
    return parser


def collect_items(ns: Args) -> list[str]:
    """Return the list of items for whichever source flag was given."""
    if ns.pattern is not None:
        return sorted(glob.glob(ns.pattern, recursive=True))

    if ns.lines_file is not None:
        stream = (
            sys.stdin if ns.lines_file == "-" else open(ns.lines_file, encoding="utf-8")
        )
        try:
            return [line.rstrip("\n") for line in stream if line.strip()]
        finally:
            if stream is not sys.stdin:
                stream.close()

    if ns.num_range is not None:
        start, end = ns.num_range
        step = 1 if start <= end else -1
        return [str(n) for n in range(start, end + step, step)]

    assert ns.items is not None  # guaranteed by the required mutually-exclusive group
    return list(ns.items)


def main(argv: list[str]) -> int:
    ns = build_parser().parse_args(argv, namespace=Args())

    # -L's nargs='+' greedily eats the trailing COMMAND too. Reclaim it: a
    # trailing list token is the command only if it contains the {} placeholder.
    if ns.items is not None and ns.command is None and "{}" in ns.items[-1]:
        ns.command = ns.items.pop()

    items = collect_items(ns)

    if ns.command is None:
        for item in items:
            print(item)
        return 0

    if "{}" not in ns.command:
        raise ValueError("COMMAND does not contain the {} placeholder")

    failures = 0
    for item in items:
        cmd = ns.command.replace("{}", shlex.quote(item))
        if subprocess.run(cmd, shell=True).returncode != 0:
            failures += 1
    return 1 if failures else 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except KeyboardInterrupt:
        sys.exit(130)
    except (OSError, ValueError) as exc:
        sys.stderr.write(f"enumerate: {exc}\n")
        sys.exit(2)
