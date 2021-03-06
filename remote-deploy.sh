#!/bin/bash

set -e

ssh hakyll@emayhew.com zsh <<'EOF'
export PATH=$HOME/.local/bin:$PATH
set -e
cd computing-workshop
git fetch
git reset --hard origin/master
git submodule update
./build.sh
./deploy.sh
EOF

echo ">>> DEPLOY COMPLETE"
