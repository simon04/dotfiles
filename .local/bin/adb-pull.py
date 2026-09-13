#! /usr/bin/env python3
import argparse
import datetime
import pathlib
import re
import shutil
import subprocess


class Arguments:
    start: datetime.date
    end: datetime.date
    remote_path: str
    local_path: pathlib.Path | None
    target: pathlib.Path


parser = argparse.ArgumentParser(
    description="Pull images from Android device in a date range",
)
parser.add_argument("start", type=datetime.date.fromisoformat)
parser.add_argument("end", type=datetime.date.fromisoformat)
parser.add_argument("--remote-path", default="/sdcard/DCIM/Camera/")
parser.add_argument("--local-path", type=pathlib.Path)
parser.add_argument("--target", default="~/Fotos/", type=pathlib.Path)
args = parser.parse_args(namespace=Arguments)
args.target = args.target.expanduser()


def date_in_range(name: str) -> datetime.date | None:
    if not (m := re.search(r"\d{4}\d{2}\d{2}", name)):
        return None
    d = datetime.datetime.strptime(m.group(), "%Y%m%d").date()
    return d if args.start <= d <= args.end else None


def make_target(date: datetime.date) -> pathlib.Path:
    target = args.target.joinpath(str(date.year)).joinpath(date.isoformat())
    target.mkdir(parents=True, exist_ok=True)
    return target


if args.local_path:
    images = [
        (img, d)
        for img in args.local_path.expanduser().iterdir()
        if img.is_file()
        if (d := date_in_range(img.name))
    ]
    for img, date in sorted(images):
        shutil.copy2(img, make_target(date))
    raise SystemExit

p = subprocess.run(
    ["adb", "shell", "ls", args.remote_path],
    capture_output=True,
    check=True,
    text=True,
)

images = [(img, d) for img in p.stdout.splitlines() if (d := date_in_range(img))]

for img, date in sorted(images):
    subprocess.run(
        ["adb", "pull", args.remote_path + img, str(make_target(date))], check=True
    )
