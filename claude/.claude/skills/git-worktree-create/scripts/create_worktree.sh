#!/bin/bash

# Git Worktree Creator
# Creates a git worktree in .worktrees/<branch-name> for the specified branch

set -e

BRANCH_NAME="$1"
WORKTREES_DIR=".worktrees"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Sanitize branch name for use as directory name (replace / with -)
WORKTREE_NAME="${BRANCH_NAME//\//-}"

# Inform user if branch name was sanitized
if [ "$WORKTREE_NAME" != "$BRANCH_NAME" ]; then
    info "Branch name contains '/', using sanitized directory name: $WORKTREE_NAME"
fi

# Validate arguments
if [ -z "$BRANCH_NAME" ]; then
    error "Branch name is required. Usage: $0 <branch-name>"
fi

# Validate we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    error "Not in a git repository"
fi

# Get the repository root
REPO_ROOT=$(git rev-parse --show-toplevel)
cd "$REPO_ROOT"

info "Repository root: $REPO_ROOT"

# Fetch from remote
info "Fetching from remote..."
git fetch --all

# Check if worktree already exists
WORKTREE_PATH="$WORKTREES_DIR/$WORKTREE_NAME"
if [ -d "$WORKTREE_PATH" ]; then
    info "Worktree already exists at $WORKTREE_PATH"
    info "Updating to latest commit..."

    # Change to worktree directory
    cd "$WORKTREE_PATH"

    # Check if we're on a branch or detached HEAD
    if git symbolic-ref -q HEAD > /dev/null; then
        # We're on a branch, just pull
        git pull
    else
        # Detached HEAD - fetch and checkout the specific commit
        info "Worktree is in detached HEAD state, fetching latest..."
        git fetch origin "$BRANCH_NAME"
        git checkout "origin/$BRANCH_NAME"
    fi

    success "✅ Worktree updated successfully at $WORKTREE_PATH"
    echo ""
    echo "To switch to the worktree, run:"
    echo "  cd $REPO_ROOT/$WORKTREE_PATH"
    exit 0
fi

# Check if branch exists locally
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
    info "Branch '$BRANCH_NAME' found locally"
    BRANCH_REF="$BRANCH_NAME"
# Check if branch exists in remote
else
    info "Branch '$BRANCH_NAME' not found locally, checking remotes..."

    # Get all remotes
    REMOTES=($(git remote))

    if [ ${#REMOTES[@]} -eq 0 ]; then
        error "No remotes configured and branch '$BRANCH_NAME' doesn't exist locally"
    fi

    # Determine which remote to use
    SELECTED_REMOTE=""

    if [ ${#REMOTES[@]} -eq 1 ]; then
        SELECTED_REMOTE="${REMOTES[0]}"
        info "Using remote: $SELECTED_REMOTE"
    else
        # Check for 'origin' first
        if [[ " ${REMOTES[@]} " =~ " origin " ]]; then
            SELECTED_REMOTE="origin"
            info "Multiple remotes found, defaulting to 'origin'"
        else
            # Multiple remotes and no 'origin', ask user
            echo "Multiple remotes found. Please select one:"
            select remote in "${REMOTES[@]}"; do
                if [ -n "$remote" ]; then
                    SELECTED_REMOTE="$remote"
                    break
                fi
            done
        fi
    fi

    # Check if branch exists on selected remote
    if git show-ref --verify --quiet "refs/remotes/$SELECTED_REMOTE/$BRANCH_NAME"; then
        info "Branch '$BRANCH_NAME' found on remote '$SELECTED_REMOTE'"
        BRANCH_REF="$SELECTED_REMOTE/$BRANCH_NAME"
    else
        error "Branch '$BRANCH_NAME' not found on remote '$SELECTED_REMOTE' or locally"
    fi
fi

# Create .worktrees directory if it doesn't exist
if [ ! -d "$WORKTREES_DIR" ]; then
    info "Creating $WORKTREES_DIR directory..."
    mkdir -p "$WORKTREES_DIR"
fi

# Create the worktree
info "Creating worktree at $WORKTREE_PATH..."
git worktree add "$WORKTREE_PATH" "$BRANCH_REF"

# Check if Claude config files are tracked in git
CLAUDE_FILES_TRACKED=false

if git ls-files --error-unmatch CLAUDE.md > /dev/null 2>&1 || \
   git ls-files --error-unmatch .claude > /dev/null 2>&1; then
    CLAUDE_FILES_TRACKED=true
    info "Claude config files are tracked in git, they will be available in the worktree"
else
    info "Claude config files are not tracked in git, copying from repo root..."

    # Copy CLAUDE.md if it exists
    if [ -f "CLAUDE.md" ]; then
        cp "CLAUDE.md" "$WORKTREE_PATH/"
        success "Copied CLAUDE.md to worktree"
    fi

    # Copy .claude directory if it exists
    if [ -d ".claude" ]; then
        cp -r ".claude" "$WORKTREE_PATH/"
        success "Copied .claude/ to worktree"
    fi

    if [ ! -f "CLAUDE.md" ] && [ ! -d ".claude" ]; then
        info "No Claude config files found in repo root to copy"
    fi
fi

success "✅ Worktree created successfully at $WORKTREE_PATH"
echo ""
echo "To switch to the worktree, run:"
echo "  cd $REPO_ROOT/$WORKTREE_PATH"
