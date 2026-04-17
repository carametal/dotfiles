#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

[ -z "$PERCENTAGE" ] && exit 0

LABEL="${PERCENTAGE}%"

if [[ -n "$CHARGING" ]]; then
  sketchybar --set "$NAME" \
    label="+ $LABEL" \
    label.color=0xff9dc814
elif [ "$PERCENTAGE" -le 20 ]; then
  sketchybar --set "$NAME" \
    label="! $LABEL" \
    label.color=0xfff38ba8
elif [ "$PERCENTAGE" -le 40 ]; then
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xfffab387
else
  sketchybar --set "$NAME" \
    label="$LABEL" \
    label.color=0xffcdd6f4
fi
