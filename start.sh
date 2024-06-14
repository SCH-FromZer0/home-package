#!/bin/bash

if (( $EUID != 0 )); then
  echo "[Privilege Error] This script must be run as root"
  exit 1
fi

/bin/bash ./update.sh
/bin/bash ./setup.sh
