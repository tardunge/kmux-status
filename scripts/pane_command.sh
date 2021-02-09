#!/usr/bin/env bash

main() {
  local pane_pid=$(tmux display-message -p "#{pane_pid}")
  pstree $pane_pid
}

main
