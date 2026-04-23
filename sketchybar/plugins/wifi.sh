#!/bin/bash

SSID=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')

if [[ -z "$SSID" || "$SSID" == "You are not associated with an AirPort network." ]]; then
  sketchybar --set "$NAME" \
    label="No WiFi" \
    label.color=0x663c3c43
else
  sketchybar --set "$NAME" \
    label="$SSID" \
    label.color=0xff6e6e73
fi
