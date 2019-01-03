#!/bin/bash

BASE_NAME=nameless-cw-certificate.png

NAME="$1"
OUTNAME="$2"
CAPSNAME="$(echo "$NAME" | tr '[a-z]' '[A-Z]')"
NICENAME="$(echo "$NAME" | tr '[A-Z]' '[a-z]' | sed 's/ /-/g')"

convert "$BASE_NAME" -fill black -pointsize 155 -font 'Karmatic-Arcade' \
        -gravity Center \
        -annotate +0-550 "$CAPSNAME" \
        "$OUTNAME"
