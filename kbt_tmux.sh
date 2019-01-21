#!/data/data/com.termux/files/usr/bin/bash

# start tmux session for kbfs if it isn't running
tmuxsess="$(tmux ls)"
kbfstmux="$(echo "$tmuxsess" | grep "kbfs" | cut -d':' -f1)"

if [ "$kbfstmux" == "" ]; then
    tmux new-session -s "kbfs" -d && ~/.termux/tasker/kbt_start_kbfs.sh
    #tmux -t "kbfs" send "nohup kbfsfuse -mount-type=none > ./kbfs.log &" enter
fi

exit 0
