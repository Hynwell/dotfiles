#!/usr/bin/env bash
set -euo pipefail

module_git() {
    log_title "git"

    apt_install git

    symlink "$DOTFILES_DIR/config/git/gitconfig" "$HOME/.gitconfig"

    log_ok "git done"
}
