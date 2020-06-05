#!/bin/sh
#NOTICE: Shell, not bash, so it runs on Alpine


file_or_folder=$1
expected_code=$2

./detection.sh "$file_or_folder"
if [ $? -ne $expected_code ] ;then 
    echo "$file_or_folder expected $expected_code"
    exit 1 
fi
