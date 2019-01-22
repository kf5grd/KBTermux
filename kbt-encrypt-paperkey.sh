#!/data/data/com.termux/files/usr/bin/bash
print_usage() {
    echo "enc-paperkey - Encrypt Keybase paper key for secure storage."
    echo ""
    echo "Usage: $0 <password> <paper key>"
    echo "Note: All arguments must be Base64 encoded due to limitations"
    echo "      in the Termux Tasker plugin"
}

exit_error() {
    local message="$1"
    echo "Error: $message"
    echo ""
    print_usage
    exit 1
}

send_intent() {
    local payload="$1"
    local intent="pub.keybase.dxb.set_paper_key"

    am broadcast --user 0 -a "$intent" -e paperkey "$payload"
}

if [ "$#" -ne 2 ]; then
    exit_error "Invalid number of arguments"
fi

password="$(echo "$1" | base64 -d)"
paperkey="$(echo "$2" | base64 -d)"

send_intent "$(echo "$paperkey" | gpg2 --armor --symmetric --no-symkey-cache --cipher-algo AES256 --passphrase "$password" --batch)"
