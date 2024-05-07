#!/bin/bash

if [ -d "$1" ]; then
  echo "Enter the file type (e.g., .txt, .log):"
  read fileType
  echo "Enter the minimum file size (in bytes):"
  read minSize
  echo "Enter the owner of the files:"
  read owner  # Fixed variable name to lowercase

  # Use find command with proper quoting to handle spaces in file names
  find "$1" -type f -name "*$fileType" -size +"$minSize"c -user "$owner" -mtime 0 -exec ls -l {} \;
else
  echo "Error: $1 is not a directory"
  exit 1
fi

