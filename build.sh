#!/bin/bash

set -e

make
mv -vt cw-website/pdf \
    lessons/0/plan/0-lp.pdf \
    lessons/1/plan/1-lp.pdf \
    lessons/syllabus/syllabus.pdf
stack build
(cd cw-website ; stack exec cw-website-exe rebuild)
(cd cw-backend ; stack install)
