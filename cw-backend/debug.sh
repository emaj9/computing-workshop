#!/bin/bash

export CW_BACKEND_OUT_PATH="out.dat"
export CW_BACKEND_DEBUG=1

stack exec cw-backend-exe
