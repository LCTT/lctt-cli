# Utility to parse usage description.

set -e

# include header.
[ -n "$__INC__COMMON__ERROR" ] && return 0
export __INC__COMMON__ERROR=1

## USAGE START
# Usage: MESSAGE
# Description: Print an error message.
## USAGE END
error() {
  echo "[-] $@" > /dev/stderr
}
