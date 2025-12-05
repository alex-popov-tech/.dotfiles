---
name: git-worktree-remove
description: Remove git worktrees from .worktrees/ directory and clean up all traces. Use this when the user wants to delete a worktree they no longer need, with interactive selection if no worktree name is provided.
---

# Git Worktree Remove

## Overview

This skill removes git worktrees from the `.worktrees/` directory and ensures all traces are completely cleaned up. It can remove a specific worktree by name or present an interactive selection menu when no name is provided.

## When to Use This Skill

Use this skill when the user needs to:
- Remove a temporary worktree after completing work
- Clean up old worktrees that are no longer needed
- Free up disk space by removing unused worktrees
- Maintain a clean worktree directory

## How It Works

The skill uses a bash script (`scripts/remove_worktree.sh`) that:

1. Validates the current directory is a git repository
2. Sanitizes the worktree name (replaces `/` with `-`) to match `git-worktree-create` behavior
3. Checks if `.worktrees/` directory exists
4. If no worktree name provided, lists all worktrees and prompts for selection
5. Confirms deletion with the user
6. Removes the worktree using `git worktree remove --force`
7. Cleans up any remaining directory files
8. Prunes git's worktree administrative data
9. Removes `.worktrees/` directory if it becomes empty

## Usage

### Remove a specific worktree by name:

```bash
scripts/remove_worktree.sh <worktree-name>
```

**Examples:**
```bash
# Remove worktree by directory name
scripts/remove_worktree.sh hotfix-123

# Remove worktree using original branch name (will be auto-sanitized)
scripts/remove_worktree.sh user.name/AOF-123
# This will remove: .worktrees/user.name-AOF-123

# Both approaches work the same:
scripts/remove_worktree.sh feature/new-feature
scripts/remove_worktree.sh feature-new-feature
```

### Interactive selection (no arguments):

```bash
scripts/remove_worktree.sh
```

This will display a numbered list of available worktrees and prompt you to select one.

## Interactive Selection

When called without arguments, the script displays:

```
No worktree name provided. Available worktrees:

[1] feature-branch
[2] hotfix-123
[3] bugfix-456

Select worktree to remove (number or name):
```

You can respond with either:
- A number (e.g., `2`)
- A worktree name (e.g., `hotfix-123`)

## Safety Features

1. **Confirmation prompt**: Always asks for confirmation before removing
2. **Validation**: Checks that the worktree exists before attempting removal
3. **Error handling**: Clear error messages if worktree not found or not in a git repo
4. **Force removal**: Uses `--force` flag to handle worktrees with uncommitted changes

## Complete Cleanup

The script ensures no traces remain by:
- Removing the worktree directory (`.worktrees/<worktree-name>`)
- Removing git's internal worktree tracking data
- Pruning stale worktree entries
- Cleaning up the `.worktrees/` directory if empty

## Error Handling

The script will error if:
- Not in a git repository
- No `.worktrees/` directory exists
- Specified worktree doesn't exist
- No worktrees available when using interactive mode
- User cancels the confirmation prompt

## Example Workflow

```bash
# User has finished work on hotfix-123 worktree
$ scripts/remove_worktree.sh hotfix-123

⚠️  About to remove worktree: .worktrees/hotfix-123
Are you sure? (y/N): y

Removing worktree...
✅ Worktree removed successfully
Pruning worktree administrative data...
✅ Worktree 'hotfix-123' has been completely removed

All traces of the worktree have been cleaned up.
```
