#!/bin/bash

set -e

stack exec cw-website-exe rebuild
(cd _site ; python -m http.server 8000)
