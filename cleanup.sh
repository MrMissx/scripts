#!/usr/bin/bash
# Delete file ext from all subfolders

echo -ne "Enter file extention(eg: .exe) you want to delete: "
read -r TODEL

find . -type f -name "*$TODEL" -delete