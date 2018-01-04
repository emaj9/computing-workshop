#!/bin/bash

set -e

stack build
stack exec cw-website-exe rebuild
