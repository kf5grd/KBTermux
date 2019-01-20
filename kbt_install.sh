#!/bin/bash

command_status() {
    local command="$1"
    local status="$2"

    if [ "$status" -ne 0 ]; then
        echo "Error: Failed to $command"
        exit 1
    fi
}

# install required packages
apt-get -qq update
command_status "update package list" "$?"

apt-get -qq install -y \
    coreutils \
    gnupg \
    jq \
    kbfs \
    keybase \
    termux-api \
    termux-tools
command_status "install required packages" "$?"

# symlink scripts to ~/.termux/tasker so they're accessible from the
# tasker plugin
mkdir -p ~/.termux/tasker
command_status "create dir ~/.termux/tasker" "$?"
SCRIPTPATH="$(cd "$(dirname "$0")"; pwd -P)"
#ln -s "$SCRIPTPATH/kbt_encrypt_paperkey.sh" "~/.termux/tasker/kbt_encrypt_paperkey.sh"
#ln -s "$SCRIPTPATH/kbt_oneshot_login.sh" "~/.termux/tasker/kbt_oneshot_login.sh"
ln -s "$SCRIPTPATH/kbt_encrypt_paperkey.sh" "$HOME/.termux/tasker/kbt_encrypt_paperkey.sh" &&
ln -s "$SCRIPTPATH/kbt_oneshot_login.sh" "$HOME/.termux/tasker/kbt_oneshot_login.sh"
command_status "symlink scripts to ~/.termux/tasker" "$?"
