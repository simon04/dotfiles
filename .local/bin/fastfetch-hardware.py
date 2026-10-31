#!/usr/bin/env python3
"""Save the hardware summary of this host or of SSH hosts (hyfetch/fastfetch without volatile values) to text files."""

import argparse
import json
import re
import pathlib
import subprocess
import sys

FASTFETCH_CONFIG = {
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

# passed with -C /dev/stdin, so hyfetch skips its interactive first-run setup
HYFETCH_CONFIG = {
    "preset": "rainbow",
    "mode": "8bit",
    "light_dark": "dark",
    "lightness": 0.65,
    "color_align": {"mode": "horizontal"},
    "backend": "neofetch",
    "args": None,
    "distro": None,
    "pride_month_disable": True,
    "custom_ascii_path": None,
}
NEOFETCH_ARGS = (
    "--config none --stdout --memory_percent off"
    " --disable uptime packages shell editor de wm theme icons cursor term"
)

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument(
    "hosts",
    nargs="*",
    metavar="HOST",
    help="SSH destination to run hyfetch/fastfetch on (default: run locally)",
)
parser.add_argument(
    "--fastfetch",
    action="store_true",
    help="use fastfetch (more details) instead of hyfetch (neofetch backend)",
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

if args.fastfetch:
    command, config = "fastfetch --config -", FASTFETCH_CONFIG
else:
    command, config = f'hyfetch -C /dev/stdin --args="{NEOFETCH_ARGS}"', HYFETCH_CONFIG


def clean(output: str) -> str:
    """Normalize neofetch output: no user@, no underline, no used memory."""
    lines = [line.rstrip() for line in output.splitlines()]
    lines[0] = lines[0].split("@")[-1]
    lines = [line for line in lines if line and not re.fullmatch(r"-+", line)]
    lines = [re.sub(r"^Memory: .* / ", "Memory: ", line) for line in lines]
    return "\n".join(lines) + "\n"


failed = False
for host in args.hosts or [None]:
    p = subprocess.run(
        # non-interactive SSH sessions lack the Homebrew bin dirs (macOS) in PATH
        ["ssh", host, f"sh -c 'PATH=$PATH:/opt/homebrew/bin:/usr/local/bin exec {command}'"]
        if host
        else ["sh", "-c", f"exec {command}"],
        input=json.dumps(config),
        capture_output=True,
        text=True,
    )
    if p.returncode or not p.stdout.strip():
        print(f"{host or 'localhost'}: failed: {p.stderr.strip()}", file=sys.stderr)
        failed = True
        continue
    output = clean(p.stdout)
    # first line is the title, i.e. the host name
    name = output.splitlines()[0].split(".")[0]
    file = target / f"{name}.txt"
    file.write_text(output)
    print(file)

raise SystemExit(failed)
