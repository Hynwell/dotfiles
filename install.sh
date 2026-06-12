#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

# shellcheck source=lib/common.sh
source "$DOTFILES_DIR/lib/common.sh"
# shellcheck source=lib/apt.sh
source "$DOTFILES_DIR/lib/apt.sh"

# Load all modules (they define functions, don't run them yet)
for _mod in "$DOTFILES_DIR"/modules/*.sh; do
    # shellcheck disable=SC1090
    source "$_mod"
done

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --all            Install everything except docker/nvim (default)
  --minimal        Install base + shell + cli only
  --with-docker    Include docker module
  --with-nvim      Include neovim module
  --module NAME    Run only a specific module (base|shell|cli|tmux|git|just|docker|nvim)
  --no-chsh        Skip changing default shell
  -h, --help       Show this help

Examples:
  ./install.sh
  ./install.sh --with-docker --with-nvim
  ./install.sh --minimal
  ./install.sh --module nvim
EOF
}

# Defaults
RUN_BASE=1
RUN_SHELL=1
RUN_CLI=1
RUN_TMUX=1
RUN_GIT=1
RUN_JUST=1
RUN_DOCKER=0
RUN_NVIM=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --all)
            # already the default
            ;;
        --minimal)
            RUN_TMUX=0; RUN_GIT=0; RUN_JUST=0; RUN_DOCKER=0; RUN_NVIM=0
            ;;
        --with-docker)
            RUN_DOCKER=1
            ;;
        --with-nvim)
            RUN_NVIM=1
            ;;
        --module)
            shift
            RUN_BASE=0; RUN_SHELL=0; RUN_CLI=0; RUN_TMUX=0
            RUN_GIT=0;  RUN_JUST=0;  RUN_DOCKER=0; RUN_NVIM=0
            case "$1" in
                base)   RUN_BASE=1   ;;
                shell)  RUN_SHELL=1  ;;
                cli)    RUN_CLI=1    ;;
                tmux)   RUN_TMUX=1   ;;
                git)    RUN_GIT=1    ;;
                just)   RUN_JUST=1   ;;
                docker) RUN_DOCKER=1 ;;
                nvim)   RUN_NVIM=1   ;;
                *)
                    log_err "Unknown module: $1"
                    log_err "Available: base shell cli tmux git just docker nvim"
                    exit 1
                    ;;
            esac
            ;;
        --no-chsh)
            NO_CHSH=1
            export NO_CHSH
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            log_err "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
    shift
done

printf "${BOLD}${CYAN}╔══════════════════════════════╗${NC}\n"
printf "${BOLD}${CYAN}║     dotfiles installer       ║${NC}\n"
printf "${BOLD}${CYAN}╚══════════════════════════════╝${NC}\n"
printf "${DIM}  DOTFILES_DIR: %s${NC}\n\n" "$DOTFILES_DIR"

require_debian

[[ "$RUN_BASE"   -eq 1 ]] && module_base
[[ "$RUN_SHELL"  -eq 1 ]] && module_shell
[[ "$RUN_CLI"    -eq 1 ]] && module_cli
[[ "$RUN_TMUX"   -eq 1 ]] && module_tmux
[[ "$RUN_GIT"    -eq 1 ]] && module_git
[[ "$RUN_JUST"   -eq 1 ]] && module_just
[[ "$RUN_NVIM"   -eq 1 ]] && module_nvim
[[ "$RUN_DOCKER" -eq 1 ]] && module_docker

printf "\n${BOLD}${GREEN}✓ All done! Restart your shell or run: exec zsh${NC}\n"
