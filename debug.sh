#!/bin/bash

# builds the frontend
# builds the backend and runs it in the background
# builds the debug server and runs it

set -e

export CW_DEBUG_PORT=8080
export CW_BACKEND_PORT=8082
export CW_FRONTEND_PATH="../cw-website/_site"

if ! test -e .smtp.secrets ; then
    echo "No .smtp.secrets file found."
fi
source .smtp.secrets

echo ">>> BUILDING FRONTEND"

(cd cw-website ; ./build.sh "$@")

echo ">>> LAUNCHING BACKEND"

(cd cw-backend ; exec ./debug.sh "$@") &

echo ">>> STARTING DEBUG SERVER ON PORT $CW_DEBUG_PORT ..."

(cd cw-debug ; exec ./debug.sh "$@")
