#!/bin/bash

set -e

function copy-pdfs() {
    find "$1" -name '*.pdf' -exec cp -v {} cw-website/pdf \;
}

mkdir -p extra-pdf

make
copy-pdfs lessons
copy-pdfs extra-pdf
stack build
(cd cw-website ; stack exec cw-website-exe rebuild)
(cd cw-backend ; stack install)
