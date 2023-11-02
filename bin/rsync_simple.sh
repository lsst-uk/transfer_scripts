#!/bin/bash
echo "running rsync single thread" 


start_time=$(date +%s)

SOURCEDIR="$1"
TARGETDIR="$2"
rsync -a --stats --safe-links --ignore-existing --human-readable --inplace "$SOURCEDIR" "$TARGETDIR" > result_simple.log

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transfering: $duration seconds"
