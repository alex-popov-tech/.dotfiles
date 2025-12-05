#!/bin/bash

# Git Worktree Remover
# Removes a git worktree from .worktrees/<branch-name> and cleans up all traces

set -e

WORKTREE_NAME="$1"
WORKTREES_DIR=".worktrees"

# Sanitize worktree name (replace / with -) to match create-worktree behavior
# This allows users to pass either the original branch name or the sanitized directory name
if [ -n "$WORKTREE_NAME" ]; then
    WORKTREE_NAME="${WORKTREE_NAME//\//-}"
fi

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

success() {
    echo -e "${GREEN}$1${NC}"
}

info() {
    echo -e "${YELLOW}$1${NC}"
}

# Validate we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    error "Not in a git repository"
fi

# Get the repository root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

# Check if .worktrees directory exists
if [ ! -d "$WORKTREES_DIR" ]; then
    error "No .worktrees directory found in repository"
fi

# Function to list available worktrees
list_worktrees() {
    local worktrees=()

    # Find all directories in .worktrees
    for dir in "$WORKTREES_DIR"/*; do
        if [ -d "$dir" ]; then
            worktrees+=("$(basename "$dir")")
        fi
    done

    echo "${worktrees[@]}"
}

# If no worktree name provided, list available worktrees and prompt user
if [ -z "$WORKTREE_NAME" ]; then
    info "No worktree name provided. Available worktrees:"
    echo ""

    # Get list of worktrees
    worktrees=($(list_worktrees))

    if [ ${#worktrees[@]} -eq 0 ]; then
        error "No worktrees found in $WORKTREES_DIR"
    fi

    # Display worktrees with numbers
    for i in "${!worktrees[@]}"; do
        echo -e "${BLUE}[$((i+1))]${NC} ${worktrees[$i]}"
    done

    echo ""
    echo -n "Select worktree to remove (number or name): "
    read -r selection

    # Check if selection is a number
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        index=$((selection - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#worktrees[@]}" ]; then
            WORKTREE_NAME="${worktrees[$index]}"
        else
            error "Invalid selection: $selection"
        fi
    else
        # Treat as worktree name
        WORKTREE_NAME="$selection"
    fi
fi

# Validate worktree exists
WORKTREE_PATH="$WORKTREES_DIR/$WORKTREE_NAME"
if [ ! -d "$WORKTREE_PATH" ]; then
    error "Worktree not found: $WORKTREE_PATH"
fi

# Confirm before removing
echo -e "${YELLOW}⚠️  About to remove worktree: $WORKTREE_PATH${NC}"
echo -n "Are you sure? (y/N): "
read -r confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

info "Removing worktree..."

# Remove the worktree using git worktree remove
# This handles both the worktree directory and git's internal tracking
if git worktree remove "$WORKTREE_PATH" --force; then
    success "✅ Worktree removed successfully"
else
    error "Failed to remove worktree"
fi

# Double-check the directory is gone
if [ -d "$WORKTREE_PATH" ]; then
    info "Cleaning up remaining directory..."
    rm -rf "$WORKTREE_PATH"
fi

# Clean up any stale worktree entries in git's administrative files
info "Pruning worktree administrative data..."
git worktree prune

success "✅ Worktree '$WORKTREE_NAME' has been completely removed"
echo ""
echo "All traces of the worktree have been cleaned up."
