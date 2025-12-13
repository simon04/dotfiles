#! /usr/bin/env python3
import argparse
import datetime
import pathlib
import subprocess
import re


class Arguments:
    start: datetime.date
    end: datetime.date
    path: str
    target: pathlib.Path


parser = argparse.ArgumentParser(
    description="Pull images from Android device in a date range",
)
parser.add_argument("start", type=datetime.date.fromisoformat)
parser.add_argument("end", type=datetime.date.fromisoformat)
parser.add_argument("--path", default="/sdcard/DCIM/Camera/")
parser.add_argument("--target", default="~/Fotos/", type=pathlib.Path)
args = parser.parse_args(namespace=Arguments)
args.target = args.target.expanduser()

p = subprocess.run(
    ["adb", "shell", "ls", args.path],
    capture_output=True,
    check=True,
    text=True,
)

images = [
    (img, d)
    for img in p.stdout.splitlines()
    if (m := re.search(r"\d{4}\d{2}\d{2}", img))
    if (d := datetime.datetime.strptime(m.group(), "%Y%m%d").date())
    if args.start <= d <= args.end
]

for img, date in sorted(images):
    target = args.target.joinpath(str(date.year)).joinpath(date.isoformat())
    target.mkdir(parents=True, exist_ok=True)
    subprocess.run(["adb", "pull", args.path + img, str(target)], check=True)
