#! /usr/bin/env python3
import argparse
import pathlib
import re
import subprocess


class Arguments:
    root: pathlib.Path
    user: str
    dry_run: bool


parser = argparse.ArgumentParser(
    description="Point origin of MediaWiki core, extensions and skins at "
    "Gerrit: fetch via HTTPS (protocol v2, fast), push via SSH",
)
parser.add_argument("root", nargs="?", default="~/src/mediawiki", type=pathlib.Path)
parser.add_argument("--user", default="simon04")
parser.add_argument("--dry-run", "-n", action="store_true")
args = parser.parse_args(namespace=Arguments)
root = args.root.expanduser()


def git(repo: pathlib.Path, *cmd: str) -> str:
    p = subprocess.run(
        ["git", "-C", str(repo), *cmd], capture_output=True, check=True, text=True
    )
    return p.stdout.strip()


repos = [root, *sorted(root.glob("extensions/*/")), *sorted(root.glob("skins/*/"))]

for repo in repos:
    if not repo.joinpath(".git").exists():
        continue
    url = git(repo, "remote", "get-url", "origin")
    if not (m := re.search(r"gerrit\.wikimedia\.org(?::\d+)?/(?:r/)?(.+)", url)):
        print(f"skip {repo}: {url}")
        continue
    project = m.group(1)
    fetch = f"https://gerrit.wikimedia.org/r/{project}"
    push = f"ssh://{args.user}@gerrit.wikimedia.org:29418/{project}"
    print(f"{repo}: {fetch} / {push}")
    if not args.dry_run:
        git(repo, "remote", "set-url", "origin", fetch)
        git(repo, "remote", "set-url", "--push", "origin", push)
