#!/usr/bin/env python3
"""Save the hardware summary of this host or of SSH hosts (fastfetch without volatile values) to text files."""

import argparse
import json
import pathlib
import subprocess
import sys

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

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument(
    "hosts",
    nargs="*",
    metavar="HOST",
    help="SSH destination to run fastfetch on (default: run locally)",
)
parser.add_argument(
    "--target",
    default=".hosts",
    type=pathlib.Path,
    help="directory to write HOSTNAME.txt to (default: %(default)s)",
)
args = parser.parse_args()
target = args.target.expanduser()
target.mkdir(parents=True, exist_ok=True)

# non-interactive SSH sessions lack the Homebrew bin dirs (macOS) in PATH
REMOTE = "sh -c 'PATH=$PATH:/opt/homebrew/bin:/usr/local/bin exec fastfetch --config -'"

failed = False
for host in args.hosts or [None]:
    command = ["ssh", host, REMOTE] if host else ["fastfetch", "--config", "-"]
    p = subprocess.run(
        command,
        input=json.dumps(CONFIG),
        capture_output=True,
        text=True,
    )
    if p.returncode or not p.stdout:
        print(f"{host or 'localhost'}: failed: {p.stderr.strip()}", file=sys.stderr)
        failed = True
        continue
    # first line is the title module, i.e. the host name
    name = p.stdout.splitlines()[0].split(".")[0]
    file = target / f"{name}.txt"
    file.write_text(p.stdout)
    print(file)

raise SystemExit(failed)
