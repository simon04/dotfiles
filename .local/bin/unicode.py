#!/usr/bin/env python3
import re
import sys
import unicodedata

i = 0
pattern = re.compile(sys.argv[1], re.IGNORECASE) if len(sys.argv) > 1 else None
for codeptx in range(0x20000):
    if i > 20:
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
