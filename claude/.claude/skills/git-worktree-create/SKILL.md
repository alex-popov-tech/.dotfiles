---
name: git-worktree-create
description: Create git worktrees in .worktrees/ for working on different branches without touching current working directory. Use this when the user needs to switch to another branch for quick fixes or temporary work while preserving uncommitted changes in their current worktree.
---

# Git Worktree Create

## Overview

This skill creates git worktrees in a standardized `.worktrees/` directory structure, enabling work on multiple branches simultaneously without stashing or committing current changes. Each worktree is created in `.worktrees/<branch-name>` for easy organization and discovery.

## When to Use This Skill

Use this skill when the user needs to:
- Work on a different branch while preserving uncommitted changes in the current working directory
- Create a temporary worktree for quick fixes or hotfixes
- Review or test another branch without affecting current work
- Work on multiple branches simultaneously

## How It Works

The skill uses a bash script (`scripts/create_worktree.sh`) that:

1. Validates the current directory is a git repository
2. Sanitizes the branch name (replaces `/` with `-`) for use as a directory name
3. Runs `git fetch --all` to ensure remote branches are up-to-date
4. Checks if the branch exists locally, if not checks remote repositories
5. For multiple remotes, defaults to `origin` or prompts user to select
6. Creates `.worktrees/` directory if it doesn't exist
7. Creates a worktree at `.worktrees/<sanitized-branch-name>`
8. Copies Claude configuration files (CLAUDE.md, .claude/) if they are not tracked in git
9. Prints the absolute path to the worktree for easy navigation

## Usage

To create a worktree for a branch, run:

```bash
scripts/create_worktree.sh <branch-name>
```

**Arguments:**
- `<branch-name>`: Name of the branch (can be local or remote)

**Examples:**
```bash
# Create worktree for a local branch
scripts/create_worktree.sh feature/new-feature

# Create worktree for a remote branch
scripts/create_worktree.sh hotfix/urgent-fix

# Branch names with slashes are automatically sanitized
# Branch: user.name/AOF-123 → Worktree: .worktrees/user.name-AOF-123
scripts/create_worktree.sh user.name/AOF-123
```

## Error Handling

The script will error if:
- Not in a git repository
- Branch doesn't exist locally or on any remote
- A worktree already exists for that branch at `.worktrees/<branch-name>`

## Claude Configuration

The script ensures Claude configuration is available in the worktree:
- **If tracked in git**: Configuration files (CLAUDE.md, .claude/) will automatically be present in the worktree
- **If not tracked**: Configuration files are copied from the repository root to the worktree

This ensures a consistent Claude setup across all worktrees.

## Worktree Organization

All worktrees are created in the `.worktrees/` directory at the repository root:

```
repo-root/
├── .worktrees/
│   ├── feature-branch/              # Worktree for feature-branch
│   ├── hotfix-123/                  # Worktree for hotfix-123
│   ├── user.name-AOF-456/           # Worktree for user.name/AOF-456 (sanitized)
│   └── bugfix-fix-critical-issue/   # Worktree for bugfix/fix-critical-issue (sanitized)
├── .git/
└── [main working directory files]
```

This convention keeps all temporary worktrees organized and easy to find.

**Note:** Branch names containing slashes (`/`) are automatically sanitized by replacing slashes with hyphens (`-`) to avoid nested directory structures. The script will inform you when sanitization occurs.
