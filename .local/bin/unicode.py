#!/usr/bin/env python3
import argparse
import re
import unicodedata

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
    default=20,
    help="maximum number of characters to print (default: %(default)s)",
)
args = parser.parse_args()

i = 0
pattern = re.compile(args.pattern, re.IGNORECASE) if args.pattern else None
for codeptx in range(0x20000):
    if i >= args.count:
        break
    try:
        c = chr(codeptx)
        n = unicodedata.name(c)
        cat = unicodedata.category(c)
        s = f"U+{codeptx:04X}\t\\u{codeptx:04X}\t&#{codeptx:04};  \t{c:>4}\t{n:<60}"
        if not pattern or pattern.search(s):
            print(s)
            i = i + 1
    except ValueError:
        pass
