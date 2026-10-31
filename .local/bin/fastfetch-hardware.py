#!/usr/bin/env python3
"""Save the hardware summary of this host (fastfetch without volatile values) to a text file."""

import argparse
import json
import os
import pathlib
import socket
import subprocess

CONFIG = {
    "logo": None,
    "display": {"pipe": True},
    "modules": [
        {"type": "title", "format": "{host-name}"},
        "os",
        "host",
        "board",
        "bios",
        "kernel",
        "cpu",
        "gpu",
        {"type": "memory", "format": "{total}"},
        "physicalmemory",
        {"type": "swap", "format": "{total}"},
        {"type": "disk", "format": "{size-total} - {filesystem}"},
        "physicaldisk",
        "display",
        "monitor",
        {"type": "battery", "format": "{manufacturer} {model-name} ({technology})"},
        {"type": "sound", "format": "{name}"},
        "camera",
        "tpm",
    ],
}

data_home = pathlib.Path(os.environ.get("XDG_DATA_HOME") or "~/.local/share")

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument(
    "--target",
    default=data_home / "fastfetch" / "hosts",
    type=pathlib.Path,
    help="directory to write HOSTNAME.txt to (default: %(default)s)",
)
args = parser.parse_args()

p = subprocess.run(
    ["fastfetch", "--config", "-"],
    input=json.dumps(CONFIG),
    capture_output=True,
    check=True,
    text=True,
)

target = args.target.expanduser()
target.mkdir(parents=True, exist_ok=True)
file = target / f"{socket.gethostname().split('.')[0]}.txt"
file.write_text(p.stdout)
print(file)
