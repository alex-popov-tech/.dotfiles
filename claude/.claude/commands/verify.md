---
description: Run quality gates. Checks code quality, fixes issues, formats code.
allowed-tools: [Task, Read, AskUserQuestion, Skill]
---

Run comprehensive quality validation: check, fix, and format.

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
```

Based on response:
- **Auto-fix all**: Proceed to Phase 3 with both fixers
- **Fix TypeScript only**: Proceed to Phase 3 with only typescript-fixer
- **Fix ESLint only**: Proceed to Phase 3 with only eslint-fixer
- **Manual**: Exit with summary of issues

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
- If iteration >= 2: Ask user how to proceed (continue fixing or exit)

## Phase 5: Format Code

Invoke the prettier skill for final cosmetic formatting:

```
Skill: prettier
```

Report results:
- "Formatted N files" if changes made
- "All files already formatted" if no changes
- "Prettier not configured" if skipped

## Phase 6: Final Report

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  QUALITY GATES COMPLETE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Checks:
├─ ESLint: <status>
├─ TypeScript: <status>
└─ Prettier: <status>

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  <SUCCESS|FAILED>
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Edge Cases

### No Quality Agents Configured

If eslint-checker returns "not-configured" AND typescript-checker returns "not-configured":
- Skip quality checks
- Report: "No quality checks configured"
- Go directly to Phase 5

### Fixer Agent Fails

If a fixer agent fails or times out:
- Report the failure
- Ask user: "Continue without this fix?" or "Exit?"
- Don't block entire workflow for one failure

## Important Notes

1. **Parallel checks, sequential fixes** - Checkers run in parallel for speed, fixers run in sequence for safety
2. **TypeScript before ESLint** - Type fixes are structural, lint fixes are cleanup
3. **Format last** - Purely cosmetic, after all logic changes
