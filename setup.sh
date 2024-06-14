#!/bin/bash

if ! command -v docker >/dev/null 2>&1; then
    echo "[Check Fail] Docker Not Installed"
    exit 1
fi

if ! command -v docker-compose >/dev/null 2>&1; then
    echo "[Check Fail] Docker Compose Not Installed"
    exit 1
fi

services=("client" "server")

for dir in "${services[@]}"; do
    echo "[Setup] Processing $dir directory..."

    # Change to the directory
    if ! cd ./$dir; then
        echo "[Setup Failed] Failed to change directory to $dir"
        exit 1
    fi

    # Run docker-compose up
    if ! docker-compose up -d; then
        echo "[Setup Failed] Failed to start Docker Compose in $dir"
        exit 1
    fi

    # Print success message
    echo "[Setup Done] $dir started successfully"

    # Go back to the original directory
    cd ../;
done
