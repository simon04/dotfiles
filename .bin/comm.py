#!/usr/bin/env python3
import sys


def file_as_set(file: str) -> set[str]:
    with open(
        file,
    ) as f:
        lines = [line.strip() for line in f.readlines()]
        return set(lines)


def main():
    op = parse_op()
    files = sys.argv[2:]
    current_set = file_as_set(files[0])
    for file in files[1:]:
        current_set = op(current_set, file_as_set(file))
    for line in sorted(current_set):
        print(line)


def parse_op():
    if len(sys.argv) < 3:
        usage()
    op = sys.argv[1]
    if op == "difference" or op == "-":
        return set.difference
    elif op == "intersection" or op == "&":
        return set.intersection
    elif op == "symmetric_difference" or op == "^":
        return set.symmetric_difference
    elif op == "union" or op == "|":
        return set.union
    else:
        usage()


def usage():
    print(
        "Usage: ",
        sys.argv[0],
        "difference|intersection|symmetric_difference|union",
        "FILES...",
    )
    print("Read lines from FILES and perform given set operation")
    exit(1)


if __name__ == "__main__":
    main()
