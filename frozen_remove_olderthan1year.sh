#!/bin/bash

# This script removes frozen logs more than a year old. The date command below could be modified between the quotes to '1 month ago' or similar. Test the resulting timestamps before use, use at your own risk. 

# Set variable to epoch minus one year
VAR=$(date --date='1 year ago' +%s)

# Write current date and list of files to be removed to log
date >> /path/to/retention_removals.log
find /path/to/splunkfrozen/ -maxdepth 2 -type d -name "db_*" | awk -v VAR="$VAR" -F'[_]' '$2 < VAR' >> /path/to/retention_removals.log
find /path/to/splunkfrozen/ -maxdepth 2 -type d -name "rb_*"  >> /path/to/replicated_bucket_removals.log

# Execute removals
find /path/to/splunkfrozen/ -maxdepth 2 -type d -name "db_*" | awk -v VAR="$VAR" -F'[_]' '$2 < VAR' | xargs /bin/rm -rf
find /path/to/splunkfrozen/ -maxdepth 2 -type d -name "rb_*" | xargs /bin/rm -rf
