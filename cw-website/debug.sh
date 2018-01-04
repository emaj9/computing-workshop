#!/bin/bash

set -e

./build.sh
(cd _site ; python -m http.server 8000)
