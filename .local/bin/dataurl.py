#!/usr/bin/env python3
import base64
import subprocess
import sys

for filename in sys.argv[1:]:
    mimetype = subprocess.run(
        ["file", "-b", "--mime-type", filename],
        capture_output=True,
        check=True,
        text=True,
    ).stdout.strip()
    with open(filename, "rb") as f:
        encoded = base64.b64encode(f.read()).decode()
    print(f"data:{mimetype};base64,{encoded}")
