#!/bin/bash
echo "constructing list of files"

usage() {
  echo "Usage: $0 SOURCEDIR TRANSFERFILE"
  echo "  SOURCEDIR     : Source directory to find files. Must be provided"
  echo "  TRANSFERFILE  : Destination file where the list will be constructed."
  exit 1
}

# Check if the help argument is provided
if [ "$1" == "--help" ]; then
  usage
fi

# Check if the required arguments are provided
if [ -z "$1" ]; then
  usage
fi

start_time=$(date +%s)

SOURCEDIR="$1"
TRANSFERFILE="${2:-file_list.out}"

find -L "$SOURCEDIR" -type f >> "$TRANSFERFILE"

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time listing files: $duration seconds"
