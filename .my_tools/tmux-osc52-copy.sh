#!/usr/bin/env bash
# tmux copy-pipe ヘルパー: 選択テキストを OSC 52 で「外側の実端末」へ直接送る。
#
# display-popup 内は tmux の入れ子クライアント(TERM=tmux-256color)になり、
# tmux 標準の set-clipboard による OSC 52 転送は popup の外まで届かない。
# そこで実端末クライアントの tty を見つけ、OSC 52 を直接書き込む。

encoded=$(base64 | tr -d '\r\n')

# popup の入れ子クライアントは TERM=tmux-256color。それ以外=実端末を選ぶ。
target_tty=$(tmux list-clients -F '#{client_tty} #{client_termname}' |
    awk '$2 != "tmux-256color" { print $1; exit }')

# 見つからなければ先頭のクライアントにフォールバック。
if [ -z "$target_tty" ]; then
    target_tty=$(tmux list-clients -F '#{client_tty}' | head -n 1)
fi

[ -n "$target_tty" ] && printf '\033]52;c;%s\a' "$encoded" >"$target_tty"
