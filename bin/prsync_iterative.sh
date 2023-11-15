#!/bin/bash
echo "running rsync in parallel"

usage() {
  echo "Usage: $0 SOURCEDIR TARGETDIR LOGFILE BATCHPREFIX njobs"
  echo "  SOURCEDIR     : Source directory to find files. Must be provided"
  echo "  TARGETDIR     : Target directory to rsync files. Must be provided"
  echo "  LOGFILE       : Log file to write the elapsed time (default: log.out)"
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
BATCHPREFIX="${4:-batch}"
njobs="${5:-2}"

echo "$BATCHPREFIX"
job_number=0
echo "let's go"
for f in "$BATCHPREFIX"*; do
	echo "$f"
	job_logfile="${LOGFILE}-njobs-${njobs}-job-${job_number}"
	rsync -e "ssh -o ControlPath=~/.ssh/control/socket" -rL --stats --human-readable --files-from="$f" "$SOURCEDIR" "$TARGETDIR" &> "$job_logfile" &
	((job_number++))
done;
wait 

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time transferring files: $duration seconds" >> "$LOGFILE"
