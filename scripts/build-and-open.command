#!/bin/zsh
set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Building and opening WindowBackdrop.app..."
echo

"$SCRIPT_DIR/build-app.sh"
exit_code=$?

echo
if [[ $exit_code -eq 0 ]]; then
    echo "Opening WindowBackdrop.app..."
    open "$ROOT_DIR/WindowBackdrop.app"
else
    echo "Build failed with exit code $exit_code."
fi

echo
echo "Press Return to close this window."
read -r _
exit "$exit_code"
