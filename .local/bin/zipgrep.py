#!/usr/bin/env python3
"""Search file names and file contents inside zip/jar archives."""

import argparse
import re
import zipfile
from pathlib import Path, PurePosixPath

EPILOG = r"""
how it works:
  1. ARCHIVE arguments containing * ? or [ are expanded with pathlib glob
     (quote them so the shell does not expand them; ** recurses).
  2. Every member of every archive is matched against --files patterns.
     A pattern without "/" matches the member's file name in any directory;
     a pattern with "/" must match the full member path (** spans dirs).
  3. If --grep is given, matching members are searched line by line.

output:
  without --grep:  ARCHIVE!MEMBER
  with --grep:     ARCHIVE!MEMBER:LINENO:LINE
                   ARCHIVE!MEMBER: binary file matches

examples:
  # list every member of all jars below the current directory
  %(prog)s '**/*.jar'

  # find log4j classes in a lib directory
  %(prog)s 'lib/*.jar' --files 'org/apache/logging/log4j/**'

  # all *.properties files (any directory) containing "password", ignoring case
  %(prog)s '**/*.jar' --files '*.properties' --grep password -i

  # lines starting with "Main-Class" in jar manifests
  %(prog)s app.jar --files META-INF/MANIFEST.MF --grep '^Main-Class:'

  # several patterns, extract the matching members to ./out
  %(prog)s a.zip b.zip --files '*.xml' --files 'conf/**' --extract-to out
"""


def expand_archives(args: list[str]) -> list[Path]:
    """Step 1: expand glob patterns into a list of archive paths."""
    archives = []
    for arg in args:
        if not any(c in arg for c in "*?["):
            archives.append(Path(arg))
            continue
        path = Path(arg)
        base = Path(path.anchor) if path.anchor else Path()
        pattern = path.relative_to(base).as_posix()
        archives.extend(sorted(p for p in base.glob(pattern) if p.is_file()))
    return archives


def member_matches(name: str, patterns: list[str], case_sensitive: bool) -> bool:
    """Step 2: match a member path against the --files patterns."""
    path = PurePosixPath(name)
    for pattern in patterns:
        target = path if "/" in pattern else PurePosixPath(path.name)
        if target.full_match(pattern, case_sensitive=case_sensitive):
            return True
    return False


def grep_member(data: bytes, label: str, regex: re.Pattern[str], encoding: str) -> bool:
    """Step 3: print matching lines, return whether anything matched."""
    text = data.decode(encoding, errors="replace")
    if b"\0" in data[:8192]:
        if regex.search(text):
            print(f"{label}: binary file matches")
            return True
        return False
    found = False
    for lineno, line in enumerate(text.splitlines(), 1):
        if regex.search(line):
            print(f"{label}:{lineno}:{line}")
            found = True
    return found


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Search file names (glob) and file contents (regex) inside zip/jar archives.",
        epilog=EPILOG,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "archives",
        nargs="+",
        metavar="ARCHIVE",
        help="zip/jar file or glob pattern, e.g. '**/*.jar'",
    )
    parser.add_argument(
        "-f",
        "--files",
        action="append",
        metavar="GLOB",
        help="glob for member paths inside the archives, repeatable (default: all files)",
    )
    parser.add_argument(
        "-g",
        "--grep",
        metavar="REGEX",
        help="Python regex searched in each line of matching members (default: no content search)",
    )
    parser.add_argument(
        "-i",
        "--ignore-case",
        action="store_true",
        help="case-insensitive --files and --grep matching",
    )
    parser.add_argument(
        "-e",
        "--encoding",
        default="utf-8",
        help="text encoding of members for --grep (default: %(default)s)",
    )
    parser.add_argument(
        "-x",
        "--extract-to",
        metavar="DIR",
        type=Path,
        help="extract matching members, keeping their paths, into DIR (created if needed); "
        "later archives overwrite identical paths from earlier ones",
    )
    args = parser.parse_args()

    patterns = args.files or ["**"]
    regex = re.compile(args.grep, re.IGNORECASE if args.ignore_case else 0) if args.grep else None
    if args.extract_to:
        dest = args.extract_to.resolve()
        dest.mkdir(parents=True, exist_ok=True)

    for archive in expand_archives(args.archives):
        with zipfile.ZipFile(archive) as zf:
            for info in zf.infolist():
                if info.is_dir() or not member_matches(info.filename, patterns, not args.ignore_case):
                    continue
                label = f"{archive}!{info.filename}"
                if regex:
                    if not grep_member(zf.read(info), label, regex, args.encoding):
                        continue
                else:
                    print(label)
                if args.extract_to:
                    # ZipFile.extract strips drive letters, absolute paths and ".." components
                    target = Path(zf.extract(info, dest)).resolve()
                    if not target.is_relative_to(dest):
                        raise RuntimeError(f"path traversal: {label} -> {target}")


if __name__ == "__main__":
    main()
