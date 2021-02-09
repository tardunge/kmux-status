# kmux-status
tmux status-line plugin to render kube-context and pod-name indicators.

![demo](assets/kcontext.png)

# Features
- Adds kube-context with namespace to the status-line.
- Shows the pod-name in status-line for the pod being interacted in the current-pane. Works with kubectl only. The following interactions are implemented:
  * If you do kubectl `exec` -it pod.
  * If you are tailing `logs`(obviously with -f) for a pod.
  * If you are `port-forwarding` to a pod.

# Installation

If you are using zsh and tmux with kubecontext rendered on your prompt, but you deal with one kube-context at a time accross terminals, while rotating contexts over time, then imo it makes sense to have the kubecontext indicated on tmux status-line rather than having it rendered across all your terminal prompts. Incase, if you use different contexts within the scope of different shells, then you need to tap into the shell env to extract the context(it makes more sense to have it rendered in your prompt itself for this scenario).

## Requirements

- [`kubectl`](https://kubernetes.io/docs/tasks/tools/install-kubectl/) binary.
- [`pstree`](https://man7.org/linux/man-pages/man1/pstree.1.html) to fetch child processes of the current-pane.

**Note:** Please use this command to check whether tmux is able to find kubectl/pstree: `tmux run-shell -b 'command -v {kubectl}/{pstree}'`

## Install via [TPM](https://github.com/tmux-plugins/tpm/)

Add this line to your `~/.tmux.conf`

```tmux
set -g @plugin 'tardunge/kmux-status'
```

Reload configuration, then press `prefix` + `I` to install plugin.

# Usage

For rendering the current kube-context:
```tmux
# in .tmux.conf
set-option -g status-right '#{kcontext}'
```

For rendering the pod name in the current-pane:
```tmux
# in .tmux.conf
set-option -g status-right '#{kpod}'
```

These (`#{kcontext}` and `#{kpod}`) are the two available formats supported now.

# Customization

Here are available options with their default values:

```tmux
# in .tmux.conf
set-option -g @kmux-kcontext-icon "⎈" # defaults to K8
set-option -g @kmux-kpod-exec-icon "E" # defaults to E
set-option -g @kmux-kpod-log-icon "L" # defaults to L
set-option -g @kmux-kpod-port-fw-icon "P" # defaults to P
```

# License

[MIT](https://github.com/tardunge/kmux-status/blob/main/LICENSE)
