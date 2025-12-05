---
description: Run quality gates and organize commits with interactive or autonomous mode. Checks code quality, fixes issues, formats code, and creates organized commits.
allowed-tools: [Task, Bash, Read, AskUserQuestion, Skill]
---

Run comprehensive pre-commit quality validation, then organize commits into logical chunks.

## Phase 1: Parallel Quality Checks

**CRITICAL:** Launch BOTH checker agents in a SINGLE message with multiple Task tool calls for parallel execution.

```
Task 1:
  - subagent_type: "eslint-checker"
  - prompt: "Check ESLint quality. Run with auto-fix for harmless issues and report any remaining errors that need manual intervention."
  - description: "ESLint check"

Task 2:
  - subagent_type: "typescript-checker"
  - prompt: "Check TypeScript compilation. Report any type errors that need fixing."
  - description: "TypeScript check"
```

Wait for BOTH agents to complete before proceeding.

## Phase 2: Aggregate Results & User Decision

Parse JSON results from both checkers and present summary:

```
=== QUALITY CHECK RESULTS ===

ESLint:
├─ Status: <status>
├─ Auto-fixed: <count> issues
└─ Remaining: <error-count> errors, <warning-count> warnings

TypeScript:
├─ Status: <status>
└─ Errors: <count> type errors

=== OVERALL: <CLEAN|WARNINGS|ERRORS> ===
```

**If all clean** (both status: "clean" or "not-configured"):
- Report success
- Skip to Phase 5 (Format)

**If issues found**, use AskUserQuestion:

```
Question: "Quality checks found issues. How would you like to proceed?"

Options:
1. "Auto-fix all" - Run typescript-fixer then eslint-fixer
2. "Fix TypeScript only" - Only fix type errors
3. "Fix ESLint only" - Only fix lint errors
4. "Manual" - Exit, I'll fix manually
5. "Skip fixes, commit anyway" - Proceed despite issues
```

Based on response:
- **Auto-fix all**: Proceed to Phase 3 with both fixers
- **Fix TypeScript only**: Proceed to Phase 3 with only typescript-fixer
- **Fix ESLint only**: Proceed to Phase 3 with only eslint-fixer
- **Manual**: Exit with summary of issues
- **Skip fixes**: Warn user, skip to Phase 5

## Phase 3: Sequential Fixes

**IMPORTANT:** Run fixers SEQUENTIALLY, not in parallel. TypeScript fixes are structural and should complete before ESLint cleanup.

**Order: typescript-fixer FIRST, then eslint-fixer**

### If fixing TypeScript:

```
Task:
  - subagent_type: "typescript-fixer"
  - prompt: "Fix these TypeScript errors: <paste typescript-checker JSON output>. Read context, understand intent, apply safe type-correct fixes."
  - description: "Fixing TypeScript errors"
```

Wait for completion.

### If fixing ESLint (after TypeScript if both):

```
Task:
  - subagent_type: "eslint-fixer"
  - prompt: "Fix these ESLint errors: <paste eslint-checker JSON output>. These are complex issues that --fix couldn't handle. Read context and apply intelligent fixes."
  - description: "Fixing ESLint errors"
```

Wait for completion.

## Phase 4: Verify Fixes

Run parallel checkers again to verify fixes worked:

```
Task 1:
  - subagent_type: "eslint-checker"
  - prompt: "Re-check ESLint after fixes. Report any remaining issues."
  - description: "Verifying ESLint"

Task 2:
  - subagent_type: "typescript-checker"
  - prompt: "Re-check TypeScript after fixes. Report any remaining issues."
  - description: "Verifying TypeScript"
```

**If clean**: Proceed to Phase 5

**If still issues**:
- If iteration < 2: Loop back to Phase 3
- If iteration >= 2: Ask user how to proceed (continue fixing, commit anyway, or exit)

## Phase 5: Format Code

Invoke the prettier skill for final cosmetic formatting:

```
Skill: prettier
```

Report results:
- "Formatted N files" if changes made
- "All files already formatted" if no changes
- "Prettier not configured" if skipped

## Phase 6: Commit Changes

Check for uncommitted changes:

```bash
git status --short
```

**If no changes**: Report "No uncommitted changes" and exit.

**If changes exist**, ask how commits should be handled using AskUserQuestion:

```
Question: "How would you like to handle commits?"

Options:
1. "Interactive" - Review and approve each commit individually
2. "Autonomous" - Create all commits automatically
```

Then proceed based on user's choice:

### Interactive Mode (inline)

1. **Analyze changes**:
   ```bash
   git status
   git diff
   git diff --cached
   git log --oneline -20
   ```

2. **Study commit conventions** from git log

3. **Categorize into logical chunks**:
   - Group by purpose (feature, fix, refactor, test, docs, config)
   - Keep related changes together
   - Separate unrelated changes

4. **For each chunk**, use AskUserQuestion:
   ```
   Question: "Commit this chunk?"

   📦 Commit: <proposed-title>

   Files:
   - <file1>
   - <file2>

   Changes: <brief summary>

   Options:
   1. "Yes, commit" - Create this commit
   2. "Edit message" - Provide different message
   3. "Skip" - Don't commit these changes
   4. "Stop" - Stop committing, keep remaining changes staged
   ```

5. **Execute approved commits**:
   ```bash
   git add <files>
   git commit -m "<message>"
   ```

6. **Repeat** for each chunk until all processed or user stops

### Autonomous Mode (subagent)

```
Task:
  - subagent_type: "git-split-committing"
  - prompt: "Analyze all uncommitted changes. Categorize into logical chunks. Study commit history for conventions. For each chunk, present the files, changes, and proposed message. Get user approval before each commit. Create focused, atomic commits."
  - description: "Organizing commits"
```

## Phase 7: Final Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  VERIFY & COMMIT COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Checks:
├─ ✅ ESLint: <status>
├─ ✅ TypeScript: <status>
└─ ✅ Prettier: <status>

Commits Created: <count>
  • <hash> <message>
  • <hash> <message>

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ✅ SUCCESS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Edge Cases

### No Quality Agents Configured

If eslint-checker returns "not-configured" AND typescript-checker returns "not-configured":
- Skip quality checks
- Report: "No quality checks configured, proceeding to commit"
- Go directly to Phase 5

### Not a Git Repository

```bash
git rev-parse --git-dir 2>&1
```

If fails: "Not a git repository. Cannot proceed." - Exit.

### No Git User Configured

```bash
git config user.name && git config user.email
```

If missing: Warn user to configure git before committing.

### Fixer Agent Fails

If a fixer agent fails or times out:
- Report the failure
- Ask user: "Continue without this fix?" or "Exit?"
- Don't block entire workflow for one failure

## Important Notes

1. **Parallel checks, sequential fixes** - Checkers run in parallel for speed, fixers run in sequence for safety
2. **TypeScript before ESLint** - Type fixes are structural, lint fixes are cleanup
3. **Format last** - Purely cosmetic, after all logic changes
4. **Always ask before committing** - Never commit without some form of user approval
5. **Ask commit mode at Phase 6** - Only ask about commit handling after quality checks are complete and changes are ready to commit
