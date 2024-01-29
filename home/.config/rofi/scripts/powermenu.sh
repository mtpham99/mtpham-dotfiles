#!/usr/bin/env bash

poweroff=$(echo -ne "\Uf0425 Shutdown");
reboot=$(echo -ne "\Uf0709 Reboot");
sleep=$(echo -ne "\Uf04b2 Sleep");
lock=$(echo -ne "\Uf033e Lock");
options="$poweroff\n$reboot\n$sleep\n$lock"

preselection=3
while getopts prslkh-: OPT; do
    [ "${OPT}" = "-" ] && OPT=${OPTARG}
    case "$OPT" in
        p | poweroff)   preselection=0 ;;
        r | reboot)     preselection=1 ;;
        s | sleep)      preselection=2 ;;
        k | lock)       preselection=3 ;;
        *) show_usage; exit 1 ;;
    esac
done

selected="$(echo -e "$options" |
            rofi -i \
                 -theme $XDG_CONFIG_HOME/rofi/theme.rasi \
                 -dmenu -selected-row ${preselection})"

case $selected in
    "${poweroff}")
        systemctl poweroff
        ;;
    "${reboot}")
        systemctl reboot
        ;;
    "${sleep}")
        playerctl pause
        pactl set-sink-mute @DEFAULT_SINK@ true
        swaylock
        sleep 3
        systemctl suspend
        ;;
    "${lock}")
        playerctl pause
        pactl set-sink-mute @DEFAULT_SINK@ true
        swaylock
        sleep 3
        ;;
esac
