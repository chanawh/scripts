#!/bin/bash

# Define the output file
OUTPUT_FILE="system_performance_report.txt"

# Add a timestamp to the output
echo "System Performance Report - $(date)" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Collect and display CPU utilization statistics
echo "Collecting CPU utilization data..." >> $OUTPUT_FILE
sar -u 1 60 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Collect and display memory utilization statistics
echo "Collecting memory utilization data..." >> $OUTPUT_FILE
sar -r 1 60 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Collect and display I/O and transfer rate statistics
echo "Collecting I/O and transfer rate statistics..." >> $OUTPUT_FILE
sar -b 1 60 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Data collection complete. Data saved to $OUTPUT_FILE" >> $OUTPUT_FILE
