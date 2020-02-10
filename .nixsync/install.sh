#!/usr/bin/env bash

installDir="$(dirname "${BASH_SOURCE[0]}")"

packages=(
    "mpd-utils"
    "mutt"
    "firefox"
    "vim"
)

function call() {
    local pkg="${installDir}/${1}/default.nix"
    local call="with import <nixpkgs> { }; callPackage ${pkg} { }"
    echo "_: ${call}" # `_:` is necessary for `nix-env -i -E`
}

for i in "${!packages[@]}"; do
    packages[${i}]="$(call "${packages[${i}]}")"
done

echo "${packages[@]}"

nix-env --install -E "${packages[@]}"
