#!/bin/bash

set -e

make

stack build
stack exec cw-website-exe rebuild
