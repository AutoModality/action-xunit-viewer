#!/bin/bash

set -e #exit on error

DEFAULT="none" # a way to handle ordered empty arguments of bash

# inputs correspond exactly to xunit-viewer options 
# https://github.com/lukejpreston/xunit-viewer
results="${1}"
output="${2}"

if [[ -z "$results" || "$results" == "$DEFAULT" ]]; then
    echo "result file/folder is required"
    exit 1
fi

if [[ -z "$output" || "$results" == "$DEFAULT" ]]; then
    echo "output location of report file is required"
    exit 1
fi

xunit-viewer --results="$results" --output="$output"

echo ::set-output name=report-file::"$output"  #reference available to other actions
