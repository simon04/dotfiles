#!/usr/bin/env python3
import sys
import urllib.error
import urllib.request

req = urllib.request.Request(f"https://web.archive.org/save/{sys.argv[1]}", method="HEAD")
try:
    res = urllib.request.urlopen(req)
except urllib.error.HTTPError as e:
    res = e
print(f"HTTP/{res.version / 10:.1f} {res.status} {res.reason}")
print(res.headers, end="")
