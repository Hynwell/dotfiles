#!/usr/bin/env bash
set -euo pipefail

module_docker() {
    log_title "Docker"

    if has_cmd docker; then
        log_ok "Docker already installed ($(docker --version))"
        return 0
    fi

    apt_install ca-certificates gnupg lsb-release

    local arch
    arch="$(dpkg --print-architecture)"
    local codename
    codename="$(lsb_release -cs)"

    add_repo_key "docker" "https://download.docker.com/linux/ubuntu/gpg"
    add_repo_source "docker" \
        "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu ${codename} stable"

    apt_install \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin

    # Add current user to docker group
    if ! groups "$USER" | grep -q docker; then
        log_info "Adding $USER to docker group..."
        sudo usermod -aG docker "$USER"
        log_warn "Log out and back in for docker group to take effect"
    else
        log_ok "$USER already in docker group"
    fi

    sudo mkdir -p /opt/docker

    docker --version
    docker compose version

    log_ok "Docker done"
}
