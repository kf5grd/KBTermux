#!/data/data/com.termux/files/usr/bin/bash

# start kbfs in the background if it isn't running
ps="$(ps aux)"
kbfsproc="$(echo "$ps" | grep "kbfsfuse" | cut -d' ' -f1)"

if [ "$kbfsproc" == "" ]; then
    tmux send-keys -t "kbfs" "nohup kbfsfuse -mount-type=none > ./kbfs.log &" enter
fi

exit 0
