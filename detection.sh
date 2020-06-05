#!/bin/sh
#NOTICE: Shell, not bash, so it runs on Alpine

set -e

file_or_folder="$1"


suite_success(){
    file="$1"
    # look for 0 failures and errors
    # grep reports non zero code if anything but zero failures/errors
    if cat "$file" | grep "<testsuites";then
        suite_line=$(cat "$file" | grep "<testsuites")
        if echo "$suite_line" | grep "failures=\"0\"";then
            if echo "$suite_line" | grep "errors=\"0\"";then
                return 0
            else
                echo "Error found in $file: $suite_line"
                return 1
            fi
        else
            echo "Failure found in $file: $suite_line"
            return 1
        fi
    else
        echo "Skipping file without suite: $file"
    fi
}

echo "Inspecting '$file_or_folder'"

if [ -d "$file_or_folder" ];then
    for file in $file_or_folder/*.xml ; do suite_success "$file"; done
elif [ -f "$file_or_folder" ]; then
    suite_success "$file_or_folder"
else
    echo "Skipping: No file or folder found at $file_or_folder"
fi

