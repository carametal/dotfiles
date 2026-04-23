#!/bin/bash

WORKSPACE_ID="$1"

FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

if [ "$WORKSPACE_ID" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    label.color=0xff1d1d1f
else
  WINDOW_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_ID" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$WINDOW_COUNT" -gt 0 ]; then
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=0xff1d1d1f
  else
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=0x663c3c43
  fi
fi
