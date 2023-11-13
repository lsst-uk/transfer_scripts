#!/bin/bash
echo "creating batches from list of files"

usage() {
  echo "Usage: $0 TARGETDIR LOGFILE LISTOFFILES BATCHPREFIX njobs"
  echo "  LOGFILE       : Log file to write the elapsed time (default: log.out)"
  echo "  LISTOFFILES  : File with list of files to transfer (default: transfer_files.out)."
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

LOGFILE="${1:-log.out}"
LISTOFFILES="${2}"
BATCHPREFIX="${3:-batch}"
njobs="${4:-2}"

split -n l/"$njobs" "$LISTOFFILES" "$BATCHPREFIX"

end_time=$(date +%s)
duration=$((end_time - start_time))

echo "Elapsed Time splitting files: $duration seconds" >> "$LOGFILE"
