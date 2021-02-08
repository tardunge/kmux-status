#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/helpers.sh"

# fetch context and namespace
main() {
  local kcontext_icon=$(get_tmux_option "@kmux-kcontext-icon" "K8")
  local context="$(kubectl config current-context)"
  local ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")"

  echo -n "$kcontext_icon $context/$ns"
}

main
