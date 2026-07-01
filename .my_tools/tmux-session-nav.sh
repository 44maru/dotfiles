#!/usr/bin/env bash
# tmux のセッション切替で tmux-toggle-scratch 製の @scratch セッションをスキップする。
# switch-client -n/-p は全セッションを巡回してしまうため、その置き換えとして使う。
# Usage: tmux-session-nav.sh next|prev
set -uo pipefail

direction="${1:?usage: $0 next|prev}"

current="$(tmux display-message -p '#S')"

# @scratch を除いたセッション一覧(tmux list-sessions の既定順 = 名前順)
mapfile -t sessions < <(tmux list-sessions -F '#S' | grep -v '@scratch$')

count=${#sessions[@]}
((count == 0)) && exit 0

index=-1
for i in "${!sessions[@]}"; do
    if [[ "${sessions[$i]}" == "$current" ]]; then
        index=$i
        break
    fi
done

# 現在が scratch 等で一覧に無い場合は先頭へ
if ((index < 0)); then
    tmux switch-client -t "${sessions[0]}"
    exit 0
fi

case "$direction" in
next) target=$(((index + 1) % count)) ;;
prev) target=$(((index - 1 + count) % count)) ;;
*)
    echo "usage: $0 next|prev" >&2
    exit 2
    ;;
esac

tmux switch-client -t "${sessions[$target]}"
