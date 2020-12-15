#!/bin/zsh
function ensure_link() {
  FROM_FILE_PATH="$1"
  TO_FILE_PATH="$2"
  TO_DIR_PATH=$(dirname "$TO_FILE_PATH")
  mkdir -pv "$TO_DIR_PATH"
  ln -fsv "$FROM_FILE_PATH" "$TO_FILE_PATH"
}

lastarg=${@: -1}
for arg in "$@"
do
  if [[ "$arg" != "$lastarg" ]]
  then
    ensure_link $arg $lastarg
  fi
done
