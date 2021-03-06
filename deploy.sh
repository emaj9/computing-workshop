#!/bin/bash

set -e

echo ">>> DEPLOYING STATIC CONTENT"
rsync -r cw-website/_site/ /srv/http/computing-workshop/

echo ">>> RESTARTING BACKEND"
sudo systemctl restart cw-backend
