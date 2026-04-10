#!/usr/bin/env bash
# Claude Code statusLine command
# Shows: git branch | model name | context usage | actual cost

input=$(cat)

# Git branch (from cwd in the JSON)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
git_branch=""
if [ -n "$cwd" ]; then
  git_branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

# Model display name
model=$(echo "$input" | jq -r '.model.display_name // empty')

# Context usage percentage (pre-calculated)
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Actual cost from cost.total_cost_usd
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Build output parts
parts=()

if [ -n "$git_branch" ]; then
  parts+=("$(printf '\033[0;36m\xef\xa0\x85\033[0m %s' "$git_branch")")
fi

if [ -n "$model" ]; then
  parts+=("$(printf '\033[0;35m%s\033[0m' "$model")")
fi

if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  if [ "$used_int" -ge 80 ]; then
    color='\033[0;31m'
  elif [ "$used_int" -ge 50 ]; then
    color='\033[0;33m'
  else
    color='\033[0;32m'
  fi
  parts+=("$(printf "${color}ctx: %s%%\033[0m" "$used_int")")
fi

if [ -n "$cost" ]; then
  cost_fmt=$(printf '%.4f' "$cost")
  parts+=("$(printf '\033[0;33m$%s\033[0m' "$cost_fmt")")
fi

# Join parts with separator
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="$result $(printf '\033[0;90m|\033[0m') $part"
  fi
done

printf "%s" "$result"
