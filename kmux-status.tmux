#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/scripts/helpers.sh"

render_status_line() {
  local placeholder="\#{$1}"
  local kcontext="#($2)"
  local status_line_extract=$3
  local old_status_line=$(get_tmux_option $status_line_extract)
  local new_status_line=${old_status_line/$placeholder/$kcontext}

  $(set_tmux_option $status_line_extract "$new_status_line")
}

main() {
  local kcontext="$CURRENT_DIR/scripts/kcontext.sh"
  render_status_line "kcontext" "$kcontext" "status-right"
}

main
