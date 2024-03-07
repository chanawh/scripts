#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check for help flag
if [[ $1 == "-h" || $1 == "--help" ]]; then
  echo "Usage: $0 [system log file] [auth log file]"
  exit 0
fi

# Check if log files were provided
if [[ -z $1 || -z $2 ]]; then
  echo "Error: You must provide two log files."
  echo "Usage: $0 [system log file] [auth log file]"
  exit 1
fi

# Check if log files exist
if [[ ! -f $1 || ! -f $2 ]]; then
  echo "Error: Log file does not exist."
  exit 1
fi

# Define the log file locations
syslog=$1
authlog=$2

echo -e "${GREEN}System Log - Last 10 Entries${NC}"
echo "----------------------------"
awk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }' $syslog | tail -n 10
echo

echo -e "${RED}Authentication Log - Last 10 Entries${NC}"
echo "------------------------------------"
awk '{ print strftime("%Y-%m-%d %H:%M:%S"), $0; fflush(); }' $authlog | tail -n 10
echo
