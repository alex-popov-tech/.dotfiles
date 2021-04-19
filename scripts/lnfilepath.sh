#!/bin/zsh
function ensure_link() {
    local src
    src=$1
    local target
    target=$2
    local targetDir
    targetDir=$(dirname "$target")

    mkdir -p "$targetDir"
    ln -F -v -s "$src" "$target"
}

lastarg=${@: -1}
for arg in "$@"
do
  if [[ "$arg" != "$lastarg" ]]
  then
    ensure_link $arg $lastarg
  fi
done
