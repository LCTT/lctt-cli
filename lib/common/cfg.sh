#!/bin/bash
# Utility to handle configurations.

set -e

# include header.
[ -n "$__INC__COMMON__CONFIG" ] && return 0
export __INC__COMMON__CONFIG=1

[ -z "$APP_NAME" ] && APP_NAME='viz-demo'
[ -z "$__CFG__COMMON__CONFIG__PATH" ] \
    && __CFG__COMMON__CONFIG__PATH="${HOME}/.config/${APP_NAME}.conf"

## USAGE START
# Usage: FIELD [VALUE]
# Description: Load or save configuration.
## USAGE END
cfg() {
  local FIELD=
  local VALUE=

  [ $# -lt 1 -o $# -gt 2 ] && return 128 # Invalid argument to exit

  [ -e "$__CFG__COMMON__CONFIG__PATH" ] && {
    [ -f "$__CFG__COMMON__CONFIG__PATH" ] \
        || return 78 # EX_CONFIG: configuration error
  } || touch "$__CFG__COMMON__CONFIG__PATH"
  local DATA="$(cat "$__CFG__COMMON__CONFIG__PATH")"

  FIELD="$1"
  grep -q "^${FIELD}: " <<<"$DATA" || {
    DATA+=$'\n'
    DATA+="${FIELD}: "
  }

  case $# in
    1)
      grep "^${FIELD}: " <<<"$DATA" | sed "s/^${FIELD}: //g"
      ;;
    2)
      VALUE="$(sed 's#[/&\]#\\&#g' <<<"$2")"
      sed "s/^${FIELD}: .*/${FIELD}: ${VALUE}/g" <<<"$DATA" \
          | sort | uniq | grep -v '^$' > "$__CFG__COMMON__CONFIG__PATH"
      ;;
  esac
}

export -f cfg
