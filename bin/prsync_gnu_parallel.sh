#!/bin/bash
echo "running rsync in parallel" 

start_time=$(date +%s)

SOURCEDIR="$1"
TARGETDIR="$2"
jobs="$3"
nroffiles=$(ls "$SOURCEDIR" | wc -w)
setsize=$(( nroffiles/"$jobs" ))

find "$SOURCEDIR" -type f > transfer.log

end_time=$(date +%s)
duration=$((end_time - start_time))
echo "Elapsed Time creating list: $duration seconds"

cat transfer.log | parallel --will-cite -j "$jobs" rsync -aR --safe-links --ignore-existing --human-readable --inplace {} "$TARGETDIR"

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transfering: $duration seconds"
