#!/bin/sh
#NOTICE: Shell, not bash, so it runs on Alpine

set -e #exit on error

DEFAULT="none" # a way to handle ordered empty arguments of bash

# inputs correspond exactly to xunit-viewer options 
# https://github.com/lukejpreston/xunit-viewer
# results must be provided
# output may be provided, otherwise will default to results dir
results="${1}"
output="${2}"
title="${3:-Tests}"
fail="${4:-true}"


if [[ -z "$results" || "$results" == "$DEFAULT" ]]; then
    echo "result file/folder is required"
    exit 1
fi

#report_dir is where the report will live and perhaps next to the results
#useful for attaching a folder with xml and html together
if [[ -z "$output" || "$output" == "$DEFAULT" ]]; then
    
    if [ -d "$results" ];then
        report_dir="$results"
    else
        report_dir="$(dirname "$results")"
    fi
    output="$report_dir/index.html"
else
    report_dir="$(dirname "$output")"
fi

#ensure path exists
mkdir -p "$(dirname "$output")"

xunit-viewer --results="$results" --output="$output" --console=true --title="$title"


echo ::set-output name=report-file::"$output"  #reference available to other actions
echo ::set-output name=report-dir::"$report_dir"  #for easy attachment of a folder

# report non zero exit code if any failure or error detected
if "$fail" == "true";then
    ./detection.sh "$output"
fi