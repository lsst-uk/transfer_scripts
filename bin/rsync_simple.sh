#!/bin/bash
echo "running rsync single thread" 


start_time=$(date +%s)

SOURCEDIR="$1"
TARGETDIR="$2"
LOGFILE="$3"

rsync -rL --stats --human-readable --inplace "$SOURCEDIR" "$TARGETDIR" > "$LOGFILE" 2>&1

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transfering: $duration seconds"
