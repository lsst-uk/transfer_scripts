#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 input_file output_file"
    exit 1
fi

input_file="$1"
output_file="$2"

# Sort the file and then remove duplicates
sort "$input_file" | uniq > "$output_file"

echo "File processed. Duplicates removed."
