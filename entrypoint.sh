#!/bin/sh

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
    
    if [ -d "$output" ];then
        report_dir="$results"
    else
        report_dir="$(dirname "$results")"
    fi
    output="$report_dir/index.html"
fi

#ensure path exists
mkdir -p "$(dirname "$output")"

xunit-viewer --results="$results" --output="$output"

echo ::set-output name=report-file::"$output"  #reference available to other actions
