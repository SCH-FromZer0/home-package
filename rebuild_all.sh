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

echo -e "$COLOR_YELLOW [ RUN ]$COLOR_END Running update..."

services=("client" "server")

for dir in "${services[@]}"; do
    echo -e "$COLOR_YELLOW [ RE-BUILD ]$COLOR_END Processing $dir directory..."

    # Change to the directory
    if ! cd "./$dir"; then
        echo -e "$COLOR_RED [ ERROR ]$COLOR_END Failed to change directory to $dir"
        exit 1
    fi

    # Run docker-compose build
    if ! docker-compose build --no-cache; then
        if ! docker compose build --no-cache; then
            echo -e "$COLOR_RED [ ERROR ]$COLOR_END Failed to start Docker Compose for $dir"
            exit 1
        fi
    fi

    # Print success message
    echo -e "$COLOR_GREEN [ OK ]$COLOR_END $dir started successfully"

    # Go back to the original directory
    cd ../;
done

docker rmi $(docker images -f "dangling=true" -q)
echo -e "$COLOR_GREEN [ OK ]$COLOR_END Purged all dangling images"
