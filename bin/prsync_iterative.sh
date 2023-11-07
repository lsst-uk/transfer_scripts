#!/bin/bash
echo "running rsync in parallel"

usage() {
  echo "Usage: $0 SOURCEDIR TARGETDIR LOGFILE TRANSFERFILE BATCHPREFIX njobs"
  echo "  SOURCEDIR     : Source directory to find files. Must be provided"
  echo "  TARGETDIR     : Target directory to rsync files. Must be provided"
  echo "  LOGFILE       : Log file to write the elapsed time (default: log.out)"
  echo "  TRANSFERFILE  : File to store list of files to transfer (default: transfer_files.out)."
  echo "  BATCHPREFIX   : Prefix for batch files (default: batch)."
  echo "  njobs         : Number of jobs to run in parallel (default: 2)."
  exit 1
}

# Check if the help argument is provided
if [ "$1" == "--help" ]; then
  usage
fi

# Check if the required arguments are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  usage
fi

start_time=$(date +%s)

SOURCEDIR="$1"
TARGETDIR="$2"
LOGFILE="${3:-log.out}"
TRANSFERFILE="${4:-transfer_files.out}"
BATCHPREFIX="${5:-batch}"
njobs="${6:-2}"

> "$TRANSFERFILE"
find "$SOURCEDIR" -type f >> "$TRANSFERFILE"
split -n l/"$njobs" "$TRANSFERFILE" "$BATCHPREFIX"

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time listing files: $duration seconds" >> "$LOGFILE"

start_time=$(date +%s)

job_number=0
for f in "$BATCHPREFIX"*; do
	# logfile="njobs-$njobs-job-$f-$LOGFILE"
	job_logfile="njobs-${njobs}-job-${job_number}-${LOGFILE}"
	rsync -rL --stats  --inplace --human-readable --files-from="$f" "/" "$TARGETDIR" &> "$job_logfile" &
	((job_number++))
done;
wait 

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transferring files: $duration seconds" >> "$LOGFILE"
