#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Please pass in the directory to run the script as an argument"
  exit
fi

# Age (in seconds) to delete
timeDiffToDelete=600
# Path to temp dir of site
searchDir=$1
# Current Timestamp
currentTimestamp=`date +%s`
# Whitelisted files (exact match)
whitelist=(
  '.'
  '..'
  '.htaccess'
  'php_storage'
)

regularFiles="$searchDir"/*
dotFiles="$searchDir"/.*
allFiles=("${dotFiles[@]}" "${regularFiles[@]}")

# Loop through the temp dir to get files
for entry in ${allFiles[*]}
do

  # Boolean to check if file is whitelisted
  whitelisted=false

  # Loop to check if file is whitelisted
  for item in ${whitelist[*]}
  do
    if [ "$entry" = "$searchDir/$item" ]; then
      whitelisted=true
      break
    fi
  done

  if [ "$whitelisted" = "false" ]; then

    # Get Timestamp of file
    fileCreatedTimestamp=`date -r "$entry" +%s`

    # Skip if no timestamp
    if [ -z "$fileCreatedTimestamp" ]; then
      continue
    fi

    # Get the age of file
    timeDiff=`expr $currentTimestamp - $fileCreatedTimestamp`

    # Delete file if it is note whitelisted and it is >= 10 minutes
    if [ "$timeDiff" -ge "$timeDiffToDelete" ]; then
      rm -f "$entry"
    fi
  fi
done
