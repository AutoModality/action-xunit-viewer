#!/bin/bash

set -e #exit on error

DEFAULT="none" # a way to handle ordered empty arguments of bash

results="${1}"
#default is to output html at the root of the xml reports
output="${2}"

# requires a CLOUDSMITH_API_KEY env variable to push
if [[ -z $results || $results == $DEFAULT ]]; then
    echo "result file/folder is required"
    exit 1
fi

xunit-viewer --results="$results" --output="$output"