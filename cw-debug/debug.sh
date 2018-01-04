#!/bin/bash

set -e

./build.sh
exec stack exec cw-debug-exe -- "$@"
