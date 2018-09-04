#!/bin/bash

set -e

LOG=/tmp/cw-build.log

function uh-oh() {
    cat /tmp/cw-build.log
    exit 1
}

mkdir -p extra-pdf
mkdir -p cw-website/static/pdf

echo ">>> COMPILING FONTS"
make -C cw-website > "$LOG" 2>&1 || uh-oh

echo ">>> BUILDING PDFs"
make > "$LOG" 2>&1 || uh-oh

echo ">>> BUILDING HASKELL APPICATIONS"
stack build > "$LOG" 2>&1 || uh-oh

echo ">>> BUILDING FRONTEND"
(cd cw-website ; stack exec cw-website-exe rebuild) > "$LOG" 2>&1 || uh-oh
(cd cw-backend ; stack install) > "$LOG" 2>&1 || uh-oh
