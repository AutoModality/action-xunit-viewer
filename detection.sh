#!/bin/sh
#NOTICE: Shell, not bash, so it runs on Alpine

set -e

file_or_folder="$1"

# detects failures or errors because xunit-viewer unfortunately does not report
# exits with non zero code if any error or failure is found
# uses simple grep to look for failures="0" and errors="0"


find_fail(){
    target=$1
    file=$2
    suite_line=$(cat "$file" | grep "$target")
    if echo "$suite_line" | grep "failures=\"0\"";then
        return 0
    elif echo "$suite_line" | grep -L "errors=\"0\"";then
        return 0
    else
        echo "Failure found in $file: $suite_line"
        return 1
    fi
}
suite_success(){
    file="$1"
    # look for 0 failures and errors
    # grep reports non zero code if anything but zero failures/errors
    plural="<testsuites "
    singular="<testsuite "
    if cat "$file" | grep "$plural";then
        find_fail $plural $file
        return $?
    elif cat "$file" | grep "$singular";then
        find_fail $singular $file
        return $?
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

