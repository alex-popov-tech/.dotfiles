#!/bin/zsh
set -euo pipefail

find . -maxdepth 1 -type d -not -name ".*" | sed 's|^./||' | \
while IFS= read -r dir; do
    if ! stow "$dir"; then
        echo "Warning: Failed to stow $dir" >&2
    else
        echo "Successfully stowed $dir"
    fi
done
