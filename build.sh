#!/bin/bash

set -e

make
mv -vt cw-website/pdf \
    lesson-plans/0/0-lp.pdf \
    lesson-plans/1/1-lp.pdf
stack build
(cd cw-website ; stack exec cw-website-exe rebuild)
(cd cw-backend ; stack install)
