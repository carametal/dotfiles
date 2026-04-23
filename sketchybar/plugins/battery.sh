#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

[ -z "$PERCENTAGE" ] && exit 0

LABEL="${PERCENTAGE}%"

if [[ -n "$CHARGING" ]]; then
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xff0066cc
elif [ "$PERCENTAGE" -le 20 ]; then
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xffff3b30
elif [ "$PERCENTAGE" -le 40 ]; then
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xffff9500
else
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xff1d1d1f
fi
