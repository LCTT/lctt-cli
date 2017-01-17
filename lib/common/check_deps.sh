#!/bin/bash
# Utility to check dependencies.

set -e

# include header.
[ -n "$__INC__COMMON__CHECK_DEPS" ] && return 0
export __INC__COMMON__CHECK_DEPS=1

## USAGE START
# Usage: DEPENDENCY...
# Description: Check if dependencies are met.
# Arguments:
#   Return Value:
#     - 0 if all dependencies are met, or 1 otherwise.
#   Note:
#     - Missing dependencies will be set to variable MISSING_DEPS.
## USAGE END
check_deps() {
  for DEP in $@; do
    which "$DEP" >/dev/null 2>&1 || MISSING_DEPS+=" ${DEP}"
  done
  export MISSING_DEPS

  [ -n "${MISSING_DEPS}" ] && return 1 || true
}

export -f check_deps
