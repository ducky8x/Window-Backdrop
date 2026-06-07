#!/bin/zsh
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Building WindowBackdrop.app..."
echo

"$SCRIPT_DIR/build-app.sh"
exit_code=$?

echo
if [[ $exit_code -eq 0 ]]; then
    echo "Done. WindowBackdrop.app was rebuilt successfully."
else
    echo "Build failed with exit code $exit_code."
fi

echo
echo "Press Return to close this window."
read -r _
exit "$exit_code"
