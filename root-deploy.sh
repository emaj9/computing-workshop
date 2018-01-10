#!/bin/bash

set -e

cp systemd/system/cw-backend.service /etc/systemd/system
systemctl daemon-reload

sudo -u hakyll ./deploy.sh
