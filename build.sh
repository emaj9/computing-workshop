#!/bin/bash

set -e

LOG=/tmp/cw-build.log

function copy-pdfs() {
    find "$1" -name '*.pdf' -exec cp -v {} cw-website/static/pdf \;
}

function uh-oh() {
    cat /tmp/cw-build.log
    exit 1
}

mkdir -p extra-pdf

echo ">>> BUILDING PDFs"
make > "$LOG" || uh-oh

echo ">>> COPYING PDFs"
copy-pdfs lessons > "$LOG" 2>&1 || uh-oh
copy-pdfs extra-pdf > "$LOG" 2>&1 || uh-oh

echo ">>> BUILDING HASKELL APPICATIONS"
stack build > "$LOG" || uh-oh

echo ">>> BUILDING FRONTEND"
(cd cw-website ; stack exec cw-website-exe rebuild) > "$LOG" 2>&1 || uh-oh
(cd cw-backend ; stack install) > "$LOG" 2>&1 || uh-oh
