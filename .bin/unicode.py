import re
import sys
import unicodedata

i = 0
pattern = re.compile(sys.argv[1], re.IGNORECASE) if len(sys.argv) > 1 else None
for codeptx in range(0x2F00):
    if i > 20:
        break
    try:
        c = chr(codeptx)
        n = unicodedata.name(c)
        cat = unicodedata.category(c)
        s = 'U+{0:04} 0x{0:04x} {1:>4}  {2:<60}'.format(codeptx, c, n)
        if not pattern or pattern.search(s):
            print(s)
            i = i + 1
    except ValueError:
        pass
