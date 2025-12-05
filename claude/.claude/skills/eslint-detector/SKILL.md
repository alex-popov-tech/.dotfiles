---
name: eslint-detector
description: Detects ESLint configuration and available commands in a repository. Returns structured JSON output designed for consumption by the quality-gates-linter agent. Checks for ESLint config files, extracts lint commands from package.json, Makefile, and CLAUDE.md, and provides command sources for the agent to read directly.
---

## Purpose

Detect ESLint presence and available commands in a repository, returning structured JSON data specifically formatted for the quality-gates-linter agent to consume.

## When to Use

Invoke this skill during Phase 0 (Environment Detection) of the quality-gates-linter agent workflow to:
- Verify ESLint is configured in the repository
- Identify available ESLint commands (check and fix)
- Locate command sources for the agent to read directly

This skill should NOT be invoked for general code review or linting tasks - only for environment detection.

## Detection Process

### Step 1: Check for ESLint Configuration

Search for ESLint configuration files using Glob tool:
- `.eslintrc.js`
- `.eslintrc.json`
- `.eslintrc.yml`
- `.eslintrc.yaml`
- `eslint.config.js` (flat config)
- `package.json` (check for `eslintConfig` field)

If NO configuration files found:
- Set `eslintDetected: false`
- Return early with minimal JSON structure

If configuration files found:
- Set `eslintDetected: true`
- Record all found config files with paths and types
- Proceed to Step 2

### Step 2: Detect ESLint Commands

Search for ESLint commands in priority order:

#### 2a. Check CLAUDE.md (Highest Priority)

If `CLAUDE.md` exists:
- Read the file
- Search for sections: "Linting", "Development Commands", "Code Quality", "Common Commands"
- Look for command patterns:
  - Check commands: `eslint`, `lint`, `make lint`, `npm run lint`
  - Fix commands: `eslint --fix`, `lint-fix`, `make lint-fix`, `npm run lint:fix`
- Extract exact commands mentioned
- Record CLAUDE.md as source if commands found

#### 2b. Check package.json Scripts

Read `package.json` and examine the `scripts` section:

**Lint check commands** (look for these script names):
- `"lint"`
- `"eslint"`
- `"lint:check"`
- Extract as: `npm run <script-name>`

**Lint fix commands** (look for these script names):
- `"lint:fix"`
- `"lint-fix"`
- `"fix"`
- `"eslint:fix"`
- Extract as: `npm run <script-name>`

Record package.json as source if commands found.

#### 2c. Check Makefile

If `Makefile` exists:
- Read the file
- Search for targets containing `eslint` or `lint`
- Common target patterns:
  - Check: `lint`, `eslint`, `check`
  - Fix: `lint-fix`, `fix`, `format`
- Extract as: `make <target-name>`
- Record Makefile as source if commands found

#### 2d. Fallback Commands

If no commands found in any source:
- Use fallback commands:
  - Check: `npx eslint .`
  - Fix: `npx eslint --fix .`
- Record source as: `"fallback"`

### Step 3: Build JSON Response

Construct JSON object with this exact structure:

```json
{
  "eslintDetected": true,
  "configFiles": [
    {
      "path": ".eslintrc.json",
      "type": "eslintrc"
    },
    {
      "path": "package.json",
      "type": "package-config"
    }
  ],
  "commands": {
    "check": {
      "command": "npm run lint",
      "source": "package.json"
    },
    "fix": {
      "command": "npm run lint:fix",
      "source": "package.json"
    }
  },
  "commandSources": [
    "package.json"
  ]
}
```

**Field Specifications:**

- `eslintDetected` (boolean): `true` if config found, `false` otherwise
- `configFiles` (array): List of all ESLint config files found
  - `path` (string): Relative path to config file
  - `type` (string): Config type (`"eslintrc"`, `"eslint-config-js"`, `"package-config"`)
- `commands` (object): Contains check and fix commands
  - `check` (object): Lint check command
    - `command` (string): Exact command to run
    - `source` (string): Where command was found
  - `fix` (object): Lint fix command
    - `command` (string): Exact command to run
    - `source` (string): Where command was found
- `commandSources` (array): Ordered list of sources where commands were found

### Step 4: Return JSON

Output the JSON structure in a code block with clear formatting:

````markdown
## ESLint Detection Results

```json
{
  "eslintDetected": true,
  "configFiles": [...],
  "commands": {...},
  "commandSources": [...]
}
```

**Summary:**
- ESLint detected: Yes/No
- Config files: <count>
- Commands source: <primary source>
````

## Priority Rules

1. **Command Priority**: CLAUDE.md > package.json > Makefile > fallback
2. **Use First Match**: For each command type (check/fix), use the first match found
3. **Source Transparency**: Always record where commands were found
4. **Config Completeness**: List ALL config files found, not just the first one

## Edge Cases

**Multiple config files found:**
- List all in `configFiles` array
- No impact on command detection

**Command found in multiple sources:**
- Use highest priority source (CLAUDE.md wins)
- Record only the used source in `commandSources`

**Only check OR only fix command found:**
- Return the found command
- For missing command, use fallback for that specific type

**No ESLint config found:**
```json
{
  "eslintDetected": false,
  "configFiles": [],
  "commands": {},
  "commandSources": []
}
```

**ESLint config found but no commands:**
```json
{
  "eslintDetected": true,
  "configFiles": [{...}],
  "commands": {
    "check": {
      "command": "npx eslint .",
      "source": "fallback"
    },
    "fix": {
      "command": "npx eslint --fix .",
      "source": "fallback"
    }
  },
  "commandSources": ["fallback"]
}
```

## Integration with quality-gates-linter

The quality-gates-linter agent will:
1. Invoke this skill during Phase 0
2. Parse the returned JSON structure
3. Use `eslintDetected` to decide whether to proceed or exit
4. Use `commands.check.command` for verification runs
5. Use `commands.fix.command` for auto-fix attempts
6. Read files listed in `commandSources` if needed for additional context

The JSON structure is designed to provide everything the linter agent needs without requiring additional file reads for command detection.

