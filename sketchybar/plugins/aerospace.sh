#!/bin/bash

# $1 = workspace ID for this item
WORKSPACE_ID="$1"

FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

if [ "$WORKSPACE_ID" = "$FOCUSED" ]; then
  # Focused: green background, dark label
  sketchybar --set "$NAME" \
    background.drawing=on \
    label.color=0xff1e1e2e
else
  # Check if workspace has any windows
  WINDOW_COUNT=$(aerospace list-windows --workspace "$WORKSPACE_ID" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$WINDOW_COUNT" -gt 0 ]; then
    # Occupied but not focused: bright label
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=0xffcdd6f4
  else
    # Empty: dimmed
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=0x44cdd6f4
  fi
fi
