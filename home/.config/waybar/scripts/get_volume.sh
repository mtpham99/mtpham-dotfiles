#!/bin/bash

# Script to get volume
# Returns "{volume} {muted}"
# volume: percentage as whole number without % (i.e. 95% or 0.95 -> returns 95)
# muted: is muted -> returns 1 else returns 0

if [[ -z wpctl ]]; then
    echo "\"wpctl\" command not found... aborting..."
    exit 1
fi

if [[ -z $1 ]]; then
    DEVICE="@DEFAULT_SINK@" # speaker
    # DEVICE="@DEFAULT_SOURCE@" # mic
else
    DEVICE="$1"
fi

# Get volume string
string=$(wpctl get-volume $DEVICE)

# Check if muted
echo $string | grep -q '\[MUTED\]'
if [[ "$?" -eq "0" ]]; then
    muted=1

    # Also remove " [MUTED]" from volume string
    string=$(echo $string | sed 's/\ \[MUTED\]//')
else
    muted=0
fi


# Get current volume level
# 1. Removing leading "Volume: " string
# 2. Removing decimal
# 3. Remove leading zeros
volume=$(echo $string | sed 's/Volume:\ //' \
                      | sed 's/[.]//'       \
                      | sed 's/^0*//')

# If string is empty, volume was 0
if [[ -z "$volume" ]]; then
    volume="0"
fi

# Return
echo "$volume $muted"
