#!/bin/bash

COLOR_RED="\033[1;31m"
COLOR_GREEN="\033[1;32m"
COLOR_YELLOW="\033[1;33m"
COLOR_END="\033[0m"

if (( $EUID != 0 )); then
  echo -e "$COLOR_RED [ FATAL ]$COLOR_END This script must be run as root"
  exit 1
fi

echo -e "$COLOR_YELLOW [ CHECK ]$COLOR_END Checking Docker..."
if ! /bin/bash ./docker_installer.sh; then
  if ! command -v docker >/dev/null 2>&1; then
    echo -e "$COLOR_RED [ ERROR ]$COLOR_END Error while configuring docker install source"
    exit 1
  fi
fi

services=("client" "server")

for dir in "${services[@]}"; do
    echo -e "$COLOR_YELLOW [ STOP ]$COLOR_END Processing $dir directory..."

    # Change to the directory
    if ! cd "./$dir"; then
        echo -e "$COLOR_RED [ FATAL ]$COLOR_END Failed to change directory to $dir"
        exit 1
    fi

    # Run docker-compose up
    if ! docker compose stop; then
        echo -e "$COLOR_RED [ FATAL ]$COLOR_END service $dir may not running this time"
    fi

    # Print success message
    echo -e "$COLOR_GREEN [ STOP ]$COLOR_END $dir stopped successfully"

    # Go back to the original directory
    cd ../;
done

echo -e "$COLOR_GREEN [ LGTM ]$COLOR_END all containers stopped successfully"
