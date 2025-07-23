#!/usr/bin/env bash
set -e

CONFIG="install.conf.yaml"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="${DOTBOT_DIR}/bin/dotbot"

git submodule update --init --recursive

"${DOTBOT_BIN}" -d . -c "${CONFIG}" "$@"

