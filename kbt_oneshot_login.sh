#!/data/data/com.termux/files/usr/bin/bash
print_usage() {
    echo "oneshot_login - Log into Keybase via oneshot in Termux"
    echo ""
    echo "Usage: $0 <keybase username> <paper key encryption password> <encrypted paper key>"
    echo "Note: All arguments must be base64 encoded due to limitations"
    echo "      in the Termux Tasker plugin"
}

exit_error() {
    echo "Error: $1"
    echo ""
    print_usage
    exit 1
}

if [ "$#" -ne 3 ]; then
    exit_error "Invalid number of arguments"
fi

keybase_user="$(echo "$1" | base64 -d)"

# decrypt paper key
password="$(echo "$2" | base64 -d)"
encrypted_paperkey="$3"
plaintext_paperkey="$(echo "$encrypted_paperkey" | base64 -d | gpg2 --decrypt --passphrase "$password" --textmode -v --batch --no-symkey-cache 2> /dev/null)"

# just to be sure keybase is in production mode
export KEYBASE_RUN_MODE=prod

# if not logged into keybase login with oneshot
if [ "$(keybase status -j | jq -r '.LoggedIn')" != "true" ] || [ "$(keybase status -j | jq -r '.Username')" != "$keybase_user" ]; then
    keybase logout
    keybase oneshot --username "$keybase_user" --paperkey "$plaintext_paperkey"
fi

# start kbfs in the background if it isn't running
ps="$(ps aux)"
kbfsproc="$(echo "$ps" | grep kbfs | cut -d' ' -f1)"

if [ "$kbfsproc" == "" ]; then
    nohup kbfsfuse -mount-type=none > ./kbfs.log &
fi
