#!/usr/bin/env python3
import base64
import mimetypes
import sys

for filename in sys.argv[1:]:
    mimetype = mimetypes.guess_file_type(filename)[0] or "application/octet-stream"
    with open(filename, "rb") as f:
        encoded = base64.b64encode(f.read()).decode()
    print(f"data:{mimetype};base64,{encoded}")
