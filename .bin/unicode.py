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
        s = "U+{0:04X}\t\\u{0:04X}\t&#{0:04};  \t{1:>4}\t{2:<60}".format(codeptx, c, n)
        if not pattern or pattern.search(s):
            print(s)
            i = i + 1
    except ValueError:
        pass
