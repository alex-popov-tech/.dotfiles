#!/bin/bash
COMMAND=$(cat | jq -r '.tool_input.command')
BLOCKED="node_modules|__pycache__|dist/|build/"

if echo "$COMMAND" | grep -qE "$BLOCKED"; then
 echo "ERROR: Blocked directory pattern" >&2
 exit 2
fi
