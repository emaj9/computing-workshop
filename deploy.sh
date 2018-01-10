#!/bin/bash

set -e

rsync -r cw-website/_site/ /srv/http/computing-workshop/
sudo systemctl restart cw-backend
