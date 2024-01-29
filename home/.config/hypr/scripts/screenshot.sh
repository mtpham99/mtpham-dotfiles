#!/bin/bash

if [[ -z slurp ]] || [[ -z grim ]] || [[ -z notify-send ]]; then
    echo "Missing required commands..."
fi

SAVE_NAME="$(date '+%Y-%m-%d_%H:%M:%S').png"
SAVE_DIR="${XDG_PICTURES_DIR:-$HOME}/screenshots"
SAVE_PATH="${SAVE_DIR}/${SAVE_NAME}"

# Active window screenshot
# hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | grim -t png -g - $SAVE_PATH

# Select region and save
slurp | grim -t png -g - $SAVE_PATH

# Notifications
# if error
if [[ $? -ne 0 ]]; then
    notify-send -u critical "Screenshot" "Error while trying to take screenshot..." -i camera
else
    notify-send -u normal "Screenshot" "Screenshot saved to ${SAVE_PATH}" -i camera
fi
