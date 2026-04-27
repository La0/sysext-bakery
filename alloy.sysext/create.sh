#!/usr/bin/env bash
# vim: et ts=2 syn=bash
#
# alloy extension.
#

RELOAD_SERVICES_ON_MERGE="false"

function list_available_versions() {
  list_github_releases "grafana" "alloy"
}

function populate_sysext_root() {
  local sysextroot="$1"
  local arch="$2"
  local version="$3"

  local rel_arch="$(arch_transform "x86-64" "amd64" "$arch")"
  curl --parallel --fail --silent --show-error --location \
        --remote-name "https://github.com/grafana/alloy/releases/download/${version}/alloy-linux-${rel_arch}.zip"

  mkdir -p "${sysextroot}/usr/local/bin"

  unzip alloy-linux-${rel_arch}.zip -d "${sysextroot}/usr/local/bin/"
  mv "${sysextroot}/usr/local/bin/alloy-linux-${rel_arch}" "${sysextroot}/usr/local/bin/alloy"
  chmod 755 "${sysextroot}/usr/local/bin/alloy"
}
