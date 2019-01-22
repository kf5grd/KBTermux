#!/data/data/com.termux/files/usr/bin/bash

command_status() {
    local command="$1"
    local status="$2"

    if [ "$status" -ne 0 ]; then
        echo "Error: Failed to $command"
        exit 1
    fi
}

# install required packages
echo "Installing required packages..."
apt-get -qq update
command_status "update package list" "$?"

apt-get -qq install -y \
    coreutils \
    gnupg \
    jq \
    kbfs \
    keybase \
    termux-api \
    termux-tools \
    tmux
command_status "install required packages" "$?"

# symlink scripts to ~/.termux/tasker so they're accessible from the
# tasker plugin
echo "Symlinking scripts..."
mkdir -p ~/.termux/tasker
command_status "create dir ~/.termux/tasker" "$?"
SCRIPTPATH="$(cd "$(dirname "$0")"; pwd -P)"
#ln -s "$SCRIPTPATH/kbt-encrypt-paperkey.sh" "~/.termux/tasker/kbt-encrypt-paperkey.sh"
#ln -s "$SCRIPTPATH/kbt-oneshot-login.sh" "~/.termux/tasker/kbt-oneshot-login.sh"
ln -s "$SCRIPTPATH/kbt-encrypt-paperkey.sh" "$HOME/.termux/tasker/kbt-encrypt-paperkey.sh" &&
ln -s "$SCRIPTPATH/kbt-oneshot-login.sh" "$HOME/.termux/tasker/kbt-oneshot-login.sh" &&
ln -s "$SCRIPTPATH/kbt-start-kbfs.sh" "$HOME/.termux/tasker/kbt-start-kbfs.sh" &&
ln -s "$SCRIPTPATH/kbt-tmux.sh" "$HOME/.termux/tasker/kbt-tmux.sh"
command_status "symlink scripts to ~/.termux/tasker" "$?"

echo "Install complete"
