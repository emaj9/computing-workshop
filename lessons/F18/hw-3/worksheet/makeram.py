#!/usr/bin/env python

# Generates a LaTeX tabular syntax for the given RAM string in ASCII.

# each line of RAM has exactly 8 bytes
RAM = [
    "%hello78",
    "x9q17_:\n",
    "&;\n!\00\n<3",
    "T_T;comp",
    "uting-wo",
    "rkshop!!",
    "mojibake",
    "\x13\x08\x0f\x10\x17\x2a??",
    ]

def main():
    i = 0
    for i, line in enumerate(RAM):
        assert len(line) == 8

        encoding = " & ".join(
            '${:08b}$'.format(ord(c)) for c in line)
        print(
            r"\num{{ {} }} & {} \\ \hline".format(i, encoding))

if __name__ == '__main__':
    main()
