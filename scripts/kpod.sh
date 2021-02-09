#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

# fetch context and namespace
main() {
  local pane_pid=$(tmux display-message -p "#{pane_pid}")
  local pane_current_command=$(tmux display-message -p "#{pane_current_command}")

  local kpexec_icon=$(get_tmux_option "@kmux-kpod-exec-icon" "E")
  local kplog_icon=$(get_tmux_option "@kmux-kpod-log-icon" "L")
  local kpport_icon=$(get_tmux_option "@kmux-kpod-port-fw-icon" "P")

  local kp_icon=""
  if [[ $pane_current_command == *"kubectl"* ]]; then
    local pane_kube_command=$(pstree $pane_pid | tail -1 | sed 's/.*kubectl/kubectl/')

    local operation=""
    local pod_psn=""
    case $pane_kube_command in
        *"exec"* ) operation="exec";pod_psn="4";kp_icon=$kpexec_icon;;
        *"port-forward"* ) operation="port-forward";pod_psn="3";kp_icon=$kpport_icon;;
        *"logs"* ) operation="log";pod_psn="4";kp_icon=$kplog_icon;;
    esac
        
    local pod_name=$(echo $pane_kube_command | sed -E 's/--?n(amespace)? [a-z0-9\-]+//' | awk "{print "\$"$pod_psn}")
  fi

  echo -n "$kp_icon $pod_name"
}

main
