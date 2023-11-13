#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input_file output_file path_to_remove"
    echo "Example: $0 input.txt output.txt /home/uname/"
    exit 1
fi

input_file="$1"
output_file="$2"
path_to_remove="$3"

# Use sed to remove the specified path from the start of each line
sed "s|^$path_to_remove||" "$input_file" > "$output_file"

echo "Processed file saved to $output_file"
