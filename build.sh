#!/bin/bash

set -e

make
find lessons -name '*.pdf' -exec cp -v {} cw-website/pdf \;
stack build
(cd cw-website ; stack exec cw-website-exe rebuild)
(cd cw-backend ; stack install)
