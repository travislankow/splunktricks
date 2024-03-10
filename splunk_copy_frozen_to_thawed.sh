#!/bin/bash

#This script locates frozen buckets between the two timestamps and copies them to a thawed directory for reindexing operations. Epoch timestamp calculator for specific date are widely available online. 

OLDEST=1595552400
NEWEST=1596801600

find /path/to/splunkfrozen/ -maxdepth 1 -type d -name "*b_*" | awk -v OLDEST="$OLDEST" -F'[_]' '$3 > OLDEST' | awk -v NEWEST="$NEWEST" -F'[_]' '$2 < NEWEST' | xargs -I{} cp -Rau {} /path/to/thawed/thaweddb/
