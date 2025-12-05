---
name: typescript-detector
description: Detects TypeScript configuration and available compilation commands in a repository. Returns structured JSON output designed for consumption by the quality-gates-compilation agent. Checks for tsconfig.json, extracts compile commands from package.json, Makefile, and CLAUDE.md, and provides command sources for the agent to read directly.
---

## Purpose

Detect TypeScript presence and available compilation commands in a repository, returning structured JSON data specifically formatted for the quality-gates-compilation agent to consume.

## When to Use

Invoke this skill during Phase 0 (Environment Detection) of the quality-gates-compilation agent workflow to:
- Verify TypeScript is configured in the repository
- Identify available TypeScript compilation command
- Locate command source for the agent to read directly

This skill should NOT be invoked for general code review or type checking tasks - only for environment detection.

## Detection Process

### Step 1: Check for TypeScript Configuration

Search for TypeScript configuration file using Glob tool:
- `tsconfig.json`

If NO configuration file found:
- Set `typescriptDetected: false`
- Return early with minimal JSON structure

If configuration file found:
- Set `typescriptDetected: true`
- Record config file path
- Proceed to Step 2

### Step 2: Detect TypeScript Compilation Command

Search for TypeScript compilation commands in priority order:

#### 2a. Check CLAUDE.md (Highest Priority)

If `CLAUDE.md` exists:
- Read the file
- Search for sections: "Type checking", "TypeScript", "Development Commands", "Common Commands", "Compilation"
- Look for command patterns:
  - `tsc`, `typecheck`, `type-check`, `compile`, `make compile`, `npm run compile`
- Extract exact command mentioned
- Record CLAUDE.md as source if command found

#### 2b. Check package.json Scripts

Read `package.json` and examine the `scripts` section:

**Compilation commands** (look for these script names):
- `"compile"`
- `"type-check"`
- `"typecheck"`
- `"tsc"`
- `"build:types"`
- Extract as: `npm run <script-name>`

Record package.json as source if command found.

#### 2c. Check Makefile

If `Makefile` exists:
- Read the file
- Search for targets containing `tsc` or `compile`
- Common target patterns:
  - `compile`, `typecheck`, `type-check`, `tsc`
- Extract as: `make <target-name>`
- Record Makefile as source if command found

#### 2d. Fallback Command

If no command found in any source:
- Use fallback command: `npx tsc --noEmit`
- Record source as: `"fallback"`

### Step 3: Build JSON Response

Construct JSON object with this exact structure:

```json
{
  "typescriptDetected": true,
  "configFile": {
    "path": "tsconfig.json",
    "exists": true
  },
  "command": {
    "compile": "npm run compile",
    "source": "package.json"
  }
}
```

**Field Specifications:**

- `typescriptDetected` (boolean): `true` if tsconfig.json found, `false` otherwise
- `configFile` (object): TypeScript configuration file details
  - `path` (string): Relative path to tsconfig.json (always "tsconfig.json")
  - `exists` (boolean): Whether file exists (always true if detected)
- `command` (object): Compilation command details
  - `compile` (string): Exact command to run for type checking
  - `source` (string): Where command was found ("CLAUDE.md", "package.json", "Makefile", or "fallback")

### Step 4: Return JSON

Output the JSON structure in a code block with clear formatting:

````markdown
## TypeScript Detection Results

```json
{
  "typescriptDetected": true,
  "configFile": {
    "path": "tsconfig.json",
    "exists": true
  },
  "command": {
    "compile": "npm run compile",
    "source": "package.json"
  }
}
```

**Summary:**
- TypeScript detected: Yes/No
- Config file: tsconfig.json
- Command source: <source>
````

## Priority Rules

1. **Command Priority**: CLAUDE.md > package.json > Makefile > fallback
2. **Use First Match**: Use the first match found from priority list
3. **Source Transparency**: Always record where command was found
4. **Single Command**: TypeScript only needs one compile command (unlike ESLint which has check + fix)

## Edge Cases

**tsconfig.json found but no command:**
```json
{
  "typescriptDetected": true,
  "configFile": {
    "path": "tsconfig.json",
    "exists": true
  },
  "command": {
    "compile": "npx tsc --noEmit",
    "source": "fallback"
  }
}
```

**No tsconfig.json found:**
```json
{
  "typescriptDetected": false,
  "configFile": {
    "path": "tsconfig.json",
    "exists": false
  },
  "command": {}
}
```

**Command found in multiple sources:**
- Use highest priority source (CLAUDE.md wins)
- Record only the used source

**Multiple tsconfig files:**
- Only check for root `tsconfig.json`
- Project-specific configs (tsconfig.build.json, etc.) are not relevant for type checking

## Integration with quality-gates-compilation

The quality-gates-compilation agent will:
1. Invoke this skill during Phase 0
2. Parse the returned JSON structure
3. Use `typescriptDetected` to decide whether to proceed or exit
4. Use `command.compile` for running type checks
5. Read file listed in `command.source` if needed for additional context

The JSON structure is designed to provide everything the compilation agent needs without requiring additional file reads for command detection.

