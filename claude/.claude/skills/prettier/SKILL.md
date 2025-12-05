---
name: prettier
description: Detects Prettier configuration and formats code. This skill should be used for final cosmetic formatting before commits, after all logic and type fixes have been verified. Returns structured JSON with detection and format results.
---

# Prettier Formatter

## Purpose

Detect Prettier presence in a repository and format code. This skill handles detection of configuration and commands, then executes formatting. Designed for use as the final cosmetic pass before committing changes.

## When to Use

This skill should be invoked:
- After all quality checks have passed (eslint, typescript)
- Before committing changes
- When purely cosmetic code formatting is needed

This skill should NOT be invoked:
- During active development (formatting may be overwritten)
- Before quality checks (fixes may undo formatting)

## Detection Process

### Step 1: Check for Prettier Configuration

Search for Prettier configuration files using Glob tool:
- `.prettierrc`
- `.prettierrc.json`
- `.prettierrc.js`
- `.prettierrc.yaml`
- `.prettierrc.yml`
- `prettier.config.js`
- `prettier.config.cjs`
- `package.json` (check for `prettier` field or dependency)

If NO configuration found:
- Set `prettierDetected: false`
- Return early with JSON indicating not configured

If configuration found:
- Set `prettierDetected: true`
- Proceed to Step 2

### Step 2: Detect Format Command

Search for format commands in priority order:

#### 2a. Check CLAUDE.md (Highest Priority)

If `CLAUDE.md` exists:
- Read the file
- Search for sections: "Formatting", "Development Commands", "Code Style"
- Look for command patterns: `prettier`, `format`, `npm run format`
- Extract exact command mentioned
- Record CLAUDE.md as source if found

#### 2b. Check package.json Scripts

Read `package.json` and examine the `scripts` section:

**Format commands** (look for these script names):
- `"format"`
- `"format:write"`
- `"prettier"`
- `"prettier:write"`
- Extract as: `npm run <script-name>`

Record package.json as source if found.

#### 2c. Check Makefile

If `Makefile` exists:
- Search for targets containing `prettier` or `format`
- Common target patterns: `format`, `prettier`, `fmt`
- Extract as: `make <target-name>`
- Record Makefile as source if found

#### 2d. Fallback Command

If no command found in any source:
- Use fallback: `npx prettier --write .`
- Record source as: `"fallback"`

### Step 3: Execute Formatting

Run the detected format command:

```bash
<detected-command>
```

Capture the output to determine files changed.

### Step 4: Build and Return JSON Response

Construct JSON object with this structure:

```json
{
  "prettierDetected": true,
  "configFile": ".prettierrc.json",
  "command": {
    "format": "npm run format",
    "source": "package.json"
  },
  "result": {
    "status": "formatted",
    "filesChanged": 5,
    "message": "Formatted 5 files"
  }
}
```

**Field Specifications:**

- `prettierDetected` (boolean): `true` if config found, `false` otherwise
- `configFile` (string): Path to detected config file
- `command` (object): Format command details
  - `format` (string): Exact command executed
  - `source` (string): Where command was found
- `result` (object): Execution results
  - `status` (string): `"formatted"`, `"no-changes"`, or `"not-configured"`
  - `filesChanged` (number): Count of files modified
  - `message` (string): Human-readable summary

## Output Format

Return the JSON structure with a summary:

```markdown
## Prettier Format Results

```json
{
  "prettierDetected": true,
  ...
}
```

**Summary:**
- Prettier detected: Yes/No
- Files formatted: <count>
- Command used: <command>
```

## Edge Cases

**No Prettier configuration found:**
```json
{
  "prettierDetected": false,
  "configFile": null,
  "command": {},
  "result": {
    "status": "not-configured",
    "filesChanged": 0,
    "message": "Prettier not configured in this repository"
  }
}
```

**Prettier configured but no files changed:**
```json
{
  "prettierDetected": true,
  "configFile": ".prettierrc",
  "command": {
    "format": "npm run format",
    "source": "package.json"
  },
  "result": {
    "status": "no-changes",
    "filesChanged": 0,
    "message": "All files already formatted"
  }
}
```

**Command execution error:**
- Report the error in the result message
- Set status to `"error"`
- Include error details for troubleshooting
