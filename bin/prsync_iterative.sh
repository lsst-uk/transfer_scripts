#!/bin/bash
echo "running rsync in parallel" >> result_transfer_vhs_check_0.log

#start_time=$(date +%s)

SOURCEDIR="$1"
TARGETDIR="$2"
njobs="$3"

#find "$SOURCEDIR" -type f >> transfer_files_vhs_check.log
#split -n "$njobs" transfer_files_vhs_check.log batch_vhs

#end_time=$(date +%s)
#duration=$((end_time - start_time))

#echo "Elapsed Time listing files: $duration seconds" >> result_transfer_vhs_check.log

start_time=$(date +%s)

for f in batch_vhs*; do
#	logfile="log-$f.log"
	rsync -ar --stats  --inplace --human-readable --info=progress2  --files-from="$f" "/" "$TARGETDIR" &
done;
wait 

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transferring files: $duration seconds" >> result_transfer_vhs_check_0.log
