#!/bin/bash

COLOR_RED="\033[1;31m"
COLOR_GREEN="\033[1;32m"
COLOR_YELLOW="\033[1;33m"
COLOR_END="\033[0m"

if ! command -v git >/dev/null 2>&1; then
    echo -e "$COLOR_RED [ ERROR ]$COLOR_END Git Not Installed"
    exit 1
fi

services=("client" "server")
for dir in "${services[@]}"; do
  echo -e "$COLOR_YELLOW [ UPDATER ]$COLOR_END Processing $dir ..."
  if ! git submodule update --remote "$dir"; then
    echo -e "$COLOR_RED [ ERROR ]$COLOR_END Failed to update $dir"
    exit 1;
  fi

  # Print success message
  echo -e "$COLOR_GREEN [ LGTM ]$COLOR_END $dir updated successfully"
done
