#!/bin/bash

RESULTS=()

################################################################################
# Adds a result to the result array
#
# $1 uid
# $2 arg
# $3 title
# $4 subtitle
# $5 icon
# $6 valid
# $7 autocomplete
###############################################################################
addResult() {
  RESULT="<item uid='$(xmlEncode "$1")' arg='$(xmlEncode "$2")' valid='$6' autocomplete='$7'><title>$(xmlEncode "$3")</title><subtitle>$(xmlEncode "$4")</subtitle><icon>$(xmlEncode "$5")</icon></item>"
  RESULTS+=("$RESULT")
}

###############################################################################
# Prints the feedback xml to stdout
###############################################################################
getXMLResults() {
  echo "<?xml version='1.0'?><items>"

#  if [ "${#string[@]}" = "0" ]; then
#    echo "<item uid='oftask' arg='-' valid='no'><title>No results found</title><subtitle>Please try another search term</subtitle><icon></icon></item>"
#  fi

  for R in ${RESULTS[*]}; do
    echo "$R" | tr "\n" " "
  done

  echo "</items>"
}

###############################################################################
# Escapes XML special characters with their entities
###############################################################################
xmlEncode() {
  echo "$1" | sed -e 's/&/\&amp;/g' -e 's/>/\&gt;/g' -e 's/</\&lt;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g'
}

###############################################################################
# Save key=value to the workflow properties
#
# $1 key
# $2 value
# $3 non-volatile 0/1
# $4 filename (optional, filename will be "settings" if not specified)
###############################################################################
setPref() {
  if [ "$3" = "0" ]; then
    local PREFDIR="$alfred_workflow_data"
  else
    local PREFDIR="$alfred_workflow_cache"
  fi

  if [ ! -d "$PREFDIR" ]; then
    mkdir -p "$PREFDIR"
  fi

  if [ -z "$4" ]; then
    local PREFFILE="${PREFDIR}/settings"
  else
    local PREFFILE="${PREFDIR}/$4"
  fi

  if [ ! -f "$PREFFILE" ]; then
    touch "$PREFFILE"
  fi

  local KEY_EXISTS=$(grep -c "$1=" "$PREFFILE")
  if [ "$KEY_EXISTS" = "1" ]; then
    local TMP=$(grep -ve "^$1" "$PREFFILE")
    echo "$TMP" > "$PREFFILE"
  fi
  echo "$1=$2" >> "$PREFFILE"
  }

###############################################################################
# Read a value for a given key from the workflow preferences
#
# $1 key
# $2 non-volatile 0/1
# $3 filename (optional, filename will be "settings" if not specified)
###############################################################################
getPref() {
  if [ "$2" = "0" ]; then
    local PREFDIR="$alfred_workflow_data"
  else
    local PREFDIR="$alfred_workflow_cache"
  fi

  if [ ! -d "$PREFDIR" ]; then
    return
  fi

  if [ -z "$3" ]; then
    local PREFFILE="${PREFDIR}/settings"
  else
    local PREFFILE="${PREFDIR}/$3"
  fi

  if [ ! -f "$PREFFILE" ]; then
    return
  fi

  local VALUE=$(sed "/^\#/d" "$PREFFILE" | grep "$1"  | tail -n 1 | cut -d "=" -f2-)
  echo "$VALUE"
}

getLang() {
  defaults read .GlobalPreferences AppleLanguages | tr -d [:space:] | cut -c2-3
}
