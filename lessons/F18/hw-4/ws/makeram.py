#!/usr/bin/env python

# Generates a LaTeX tabular syntax for the given RAM string in ASCII.

START_OFFSET = 32
ROW_SIZE = 1

# each line of RAM has exactly 8 bytes
RAM = [
    "\x4d",
    "\x4c",
    "\x00",
    "\x00",
    "\x00",
    [None],
    [None],
    [None],
    [None]
    ]

def main():
    i = 0
    for i, line in enumerate(RAM, START_OFFSET):
        assert len(line) == ROW_SIZE

        encoding = " & ".join(
            '${:08b}$'.format(ord(c))
            if c is not None else
            '~'
            for c in line)
        print(
            r"\num{{ {} }} & {} \\ \hline".format(i * ROW_SIZE, encoding))

if __name__ == '__main__':
    main()
