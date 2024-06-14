#!/bin/bash

if ! command -v git >/dev/null 2>&1; then
    echo "[Check Fail] Git Not Installed"
    exit 1
fi

services=("client" "server")
for dir in "${services[@]}"; do
  echo "[Updater] Processing $dir ..."
  if ! git submodule update --remote "$dir"; then
    echo "[Update Failed] Failed to update $dir"
    exit 1;
  fi

  # Print success message
  echo "[Updated] $dir started successfully"
done
