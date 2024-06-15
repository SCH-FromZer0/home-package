COLOR_RED="\033[1;31m"
COLOR_GREEN="\033[1;32m"
COLOR_YELLOW="\033[1;33m"
COLOR_END="\033[0m"

if (( $EUID != 0 )); then
  echo -e "$COLOR_RED [ FATAL ]$COLOR_END This script must be run as root"
  exit 1
fi

echo -e "$COLOR_YELLOW [ RE-LAUNCHER ]$COLOR_END Starting Updating..."
if ! /bin/bash ./update.sh; then
  echo -e "$COLOR_RED [ ERROR ]$COLOR_END Error occurred while Updating!"
  exit 1
fi

echo -e "$COLOR_YELLOW [ RE-LAUNCHER ]$COLOR_END Starting Rebuild..."
if ! /bin/bash ./rebuild_all.sh; then
  echo -e "$COLOR_RED [ ERROR ]$COLOR_END Error occurred while Rebuilding!"
  exit 1
fi

echo -e "$COLOR_YELLOW [ RE-LAUNCHER ]$COLOR_END Starting Launch..."
if ! /bin/bash ./start.sh; then
  echo -e "$COLOR_RED [ ERROR ]$COLOR_END Error occurred while Launching!"
  exit 1
fi

echo -e "$COLOR_GREEN [ RE-LAUNCHER ]$COLOR_END All job done successfully!"

