#!/bin/bash
# Utility to parse usage description.

set -e

# include header.
[ -n "$__INC__COMMON__USAGE" ] && return 0
export __INC__COMMON__USAGE=1

## USAGE START
# Usage: SCRIPT [COMMAND]
# Description: Print usage information
# Arguments:
#   Variables:
#     SCRIPT: The script file contains usage information
#     COMMAND: Preceding command shown in the usage
#              (default: <file name of the script>)
#   Example:
#     - $ source usage.sh
#     - $ print_usage usage.sh
## USAGE END

print_usage() {
  local CONFIG_INDENT=2
  local CONFIG_SPACES=3

  local SCRIPT="$1"
  local COMMAND="$2"
  local COLS="$(tput cols)"

  local LVL=
  local KEY=
  local VAL=

  local MODE=
  local SEC=

  local KEY_WIDTH=0
  local MAX_KEY_WIDTH=0
  local MAX_VAL_WIDTH=0
  local MAX_PLAIN_WIDTH=0
  local MAX_WIDTH=0

  local SEC_CACHE=
  local ARGS_CACHE=
  local PLAIN=
  local PART=

  [ -z "$COMMAND" ] && COMMAND="$(basename $SCRIPT)"

  cat "$SCRIPT" \
      | awk '/USAGE START/,/USAGE END/' | grep '^# ' | sed 's/^# //g' \
      | tr '\n' '\r' | sed 's/\r \{5,\}/ /g' | tr '\r' '\n' \
      | sed '$a\  magic:' \
      | while IFS='' read LINE; do
          LVL="$(grep -o '^ *' <<<"$LINE" | wc -L)"
          KEY="$(grep -o '^[^:]*' <<<"$LINE" | sed 's/^ *//')"
          VAL="$(sed 's/^[^:]*: *\|\s*$//' <<<"$LINE")"

          [ "$LVL" = 0 ] && {
            case "$KEY" in
              Usage)
                MODE=
                echo "Usage: ${COMMAND} ${VAL}"
                ;;
              Description)
                MODE=
                echo
                echo "$VAL"
                ;;
              Arguments)
                MODE="$KEY"
                ;;
            esac
          }

          [ "$MODE" = 'Arguments' -a "$LVL" = 2 ] && {
            SEC_CACHE="$SEC"
            SEC="$KEY"
            [ -n "$ARGS_CACHE" ] && {
              echo
              echo "${SEC_CACHE}:"

              MAX_VAL_WIDTH="$((${COLS} - ${CONFIG_INDENT} \
                                        - ${MAX_KEY_WIDTH} \
                                        - ${CONFIG_SPACES}))"
              MAX_PLAIN_WIDTH="$((${COLS} - ${CONFIG_INDENT}))"
              echo "$ARGS_CACHE" | while IFS='' read PAIR; do
                KEY="$(grep -o '^[^:]*' <<<"$PAIR" | sed 's/^ *//')"
                VAL="$(sed 's/^[^:]*: *//' <<<"$PAIR")"

                grep -q '^- ' <<<"$PAIR" \
                     && {
                       PLAIN=1
                       VAL="$(sed 's/^- //' <<<"$PAIR")"
                     }

                while [ -n "$VAL" ]; do
                  [ -n "$PLAIN" ] && MAX_WIDTH="$MAX_PLAIN_WIDTH" \
                                  || MAX_WIDTH="$MAX_VAL_WIDTH"
                  PART="$(grep -oE "^.{0,${MAX_WIDTH}}( |$)" <<<"$VAL")" \
                      || {
                        # FIXME: put key and value on separate line.
                        echo "FIXME: Too narrow to output, need fix."
                        exit 1
                      }
                  VAL="$(sed "s/^.\{$(wc -L <<<"$PART")\}//" <<<"$VAL")"
                  PART="$(sed 's/ $//g' <<<"$PART")"

                  printf "%${CONFIG_INDENT}s" ''
                  [ -z "$PLAIN" ] && {
                    printf "%-${MAX_KEY_WIDTH}s" "$KEY"
                    printf "%${CONFIG_SPACES}s" ''
                  }
                  printf "%s\n" "$PART"

                  KEY=
                done

                PLAIN=
              done

              MAX_KEY_WIDTH=0
              ARGS_CACHE=
            }
          }

          [ "$MODE" = 'Arguments' -a "$LVL" = 4 ] && {
            KEY_WIDTH="$(wc -L <<<"$KEY")"
            grep -q '^- ' <<<"$KEY" && KEY_WIDTH=0
            [ "$KEY_WIDTH" -gt "$MAX_KEY_WIDTH" ] \
                && MAX_KEY_WIDTH="$KEY_WIDTH"
            grep -q '^- ' <<<"$KEY" \
                && ARGS_CACHE+="${KEY}" \
                || ARGS_CACHE+="${KEY}: ${VAL}"
            ARGS_CACHE+=$'\n'
          }
        done || true
}

export -f print_usage
