#!/usr/bin/env bash

# fetch context and namespace
main() {
  local context="$(kubectl config current-context)"
  local ns="$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$context\")].context.namespace}")"

  echo -n "$context/$ns"
}

main
