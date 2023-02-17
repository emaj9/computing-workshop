#!/bin/bash

set -e

echo ">>> DEPLOYING STATIC CONTENT"
rsync -r cw-website/_site/ computing-workshop.com:/srv/http/computing-workshop/
