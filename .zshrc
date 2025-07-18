# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

umask 022

# disable diplay lock by ctrl+s
# 下記をコメントアウトしないと、一部の機能(tmux-fzfのプレビューなど)で以下のメッセージが出力される
#   stty: 'standard input': Inappropriate ioctl for device
#stty stop undef

#-----------------------------------------------
# Base setting
#-----------------------------------------------
#export LANG=ja_JP.utf8
export LANG=en_US.utf8

if type nvim &>/dev/null; then
    export EDITOR=nvim
    export VISUAL=nvim
else
    export EDITOR=vim
    export VISUAL=vim
fi

export VISUAL=vim
export COLOR=32
export SCREENCOLOR=g
export PERL_BADLANG=0
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# save history
export HISTSIZE=100000 HISTFILE=~/.zsh_history SAVEHIST=100000

export TERM=xterm-256color


export WORDCHARS='*?[]~=&;!#$%^(){}<>'
#-----------------------------------------------
# option
#-----------------------------------------------
setopt \
    append_history \
    auto_cd \
    auto_list \
    auto_resume \
    cdable_vars \
    complete_in_word \
    equals \
    extended_glob \
    extended_history \
    NO_glob_dots \
    hist_ignore_dups \
    NO_hist_ignore_space \
    NO_ignore_eof \
    interactive_comments \
    list_types \
    long_list_jobs \
    mail_warning \
    no_bad_pattern \
    notify \
    numeric_glob_sort \
    print_exit_value \
    pushd_minus \
    pushd_silent \
    pushd_to_home \
    pushd_ignore_dups \
    rc_quotes \
    share_history \
    autopushd \
    no_beep \
    auto_param_slash \
    magic_equal_subst \
#    NO_clobber \  # disable to save for exiting file.

autoload -U compinit; compinit
autoload colors; colors

# delete scp auto completion
zstyle ':completion:*:complete:scp:*:files' command command -

#-----------------------------------------------
# vi-keys
#-----------------------------------------------
bindkey -v
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^K" vi-change-eol
bindkey "^R" history-incremental-search-backward

#-----------------------------------------------
# These works in linux+xterm+ssh setup:
#-----------------------------------------------
bindkey "^[[1~" vi-beginning-of-line # Home
bindkey "^[[4~" vi-end-of-line # End
bindkey "^[[2~" beep # Insert
bindkey "^[[3~" delete-char # Del
bindkey -e

#-----------------------------------------------
# Get git file remote url
#-----------------------------------------------
function giturl() {
    local filename=$1
    local git_top_dir=`git rev-parse --show-superproject-working-tree --show-toplevel | head -1`
    local git_pj_url=`git remote -v | head -n1 | awk '{print $2}' | sed 's/.git$//'`
    local path_under_top_dir=`echo $PWD | sed "s%$git_top_dir%%"`
    local current_branch=`git symbolic-ref --short HEAD`
    local url=$git_pj_url/-/blob/$current_branch/$path_under_top_dir/$filename
    echo $url | clipboard
    test -f /usr/bin/xsel && echo $url | xsel -bi
}

function githuburl() {
    local filename=$1
    local git_top_dir=`git rev-parse --show-superproject-working-tree --show-toplevel | head -1`
    local git_pj_url=`git remote -v | head -n1 | awk '{print $2}' | sed 's/.git$//'`
    local path_under_top_dir=`echo $PWD | sed "s%$git_top_dir%%"`
    local current_branch=`git symbolic-ref --short HEAD | sed 's%heads/%%'`
    local url=$git_pj_url/blob/$current_branch/$path_under_top_dir/$filename
    echo $url | clipboard
    test -f /usr/bin/xsel && echo $url | xsel -bi
}

#-----------------------------------------------
# Display Git branch on prompt
#-----------------------------------------------
# http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT='
%B%{${fg[red]}%}[%n%{${fg[blue]}%}@%m${WINDOW:+":$WINDOW"}]%{%(?.$fg[blue].$fg[red])%}${vcs_info_msg_0_} [%~]
%(!.#.$)%{${reset_color}%}%b '

#RPROMPT="[%~]"
RPROMPT=""

#SPROMPT="%B%r is correct? [n,y,a,e]:%b "
SPROMPT="correct: %R -> %r ? "


typeset -ga chpwd_functions

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.my_tools:$PATH

#-----------------------------------------------
# Python setting
#-----------------------------------------------
export PYTHONUSERBASE=$HOME/.python
export PATH=$PYTHONUSERBASE/bin:$PATH
export PIPENV_VENV_IN_PROJECT=true

#-----------------------------------------------
# Golang
#-----------------------------------------------
# system go
export PATH=$HOME/go/bin:$PATH
# additional installed go
export PATH=$HOME/.local/go/bin:$PATH

# ghq
export GHQPATH=$HOME/dev
export PATH=$GHQPATH/bin:$PATH
# .gitconfigに環境変数を直接書けないので.zshrcでコマンド実行
git config --global ghq.root $GHQPATH

#-----------------------------------------------
# peco + ghq
#-----------------------------------------------
function ghq-peco () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-peco
bindkey '^]' ghq-peco # ctrl + ]

#-----------------------------------------------
# peco + history
#-----------------------------------------------
function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

#-----------------------------------------------
# peco + cdr
#-----------------------------------------------
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
# ctrl+space(ctrl+v -> ctrl+spaceで入力)でpeco-dirを実行
bindkey '^W' peco-cdr


#-----------------------------------------------
# ctrl + o で親のdirectoryへ移動
#-----------------------------------------------
# hook関数precmd実行(gitのstatusバーなどを同期)
__call_precmds() {
  type precmd > /dev/null 2>&1 && precmd
  for __pre_func in $precmd_functions; do $__pre_func; done
}

#ctrl+oで親ディレクトリへ
__cd_up()   { builtin cd ..; echo "\r\n"; __call_precmds; zle reset-prompt }
zle -N __cd_up;   bindkey '^o' __cd_up

#-------------------
# fzf
#-------------------
[ -f ~/.fzf.zsh ] && {
    # systemにfzfがインストールされているとバイナリはsystem, 設定はlocalのものが適用され正しく動作しない可能性があるので明示的に
    # localを優先するようPATHを更新
    export PATH=$HOME/.fzf/bin:$PATH
    source ~/.fzf.zsh
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border --ansi'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
    export TMUX_FZF_OPTIONS="-p -w 80% -h 80% -m"
    export TMUX_FZF_PREVIEW=1
    # ctrl+space(ctrl+v -> ctrl+spaceで入力)でfzf-cd-widgetを実行
    bindkey '^@' fzf-cd-widget

    [ -f /usr/bin/ag ] && {
        export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
    }

    # https://askubuntu.com/questions/1290262/unable-to-install-bat-error-trying-to-overwrite-usr-crates2-json-which
    # sudo apt install --fix-broken -o Dpkg::Options::="--force-overwrite" ripgrep bat
    [ -f /usr/bin/rg ] && {
        export FZF_DEFAULT_COMMAND="rg --color always --files --hidden --glob '!.git/**'"
    }

    # sudo apt install fd-find
    [ -f /usr/bin/fdfind ] && {
        export FZF_DEFAULT_COMMAND="fdfind --color always --type file -H -E .git"
        export FZF_CTRL_T_COMMAND="fdfind --color always -H -E .git"
        export FZF_ALT_C_COMMAND="fdfind --color always -t d -H -E .git"
    }

    # 絞り込み画面の中での外部プログラムを呼び出すバインド
    #fzf --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'

}

# fzf -> vim
function fv() {
  local files
    IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0 --preview "cat --color=always --style=header,grid --line-range :100 {}"))
      [[ -n "$files"  ]] && ${EDITOR:-vim} "${files[@]}"
}

function fzf-cd () {
    local search_dir=${FZF_SEARCH_DIR:-$HOME}
    local dir=$(find $search_dir -maxdepth 1 -type d  | sed "s%$search_dir/%%" | grep -v "^\.\|^$search_dir" | fzf)
    echo $dir
    cd $search_dir/$dir
    zle reset-prompt
}
zle -N fzf-cd
bindkey '^]' fzf-cd # ctrl + ]

#-------------------
# Linuxbrew
#-------------------
#export HOMEBREW_PREFIX="$HOME/.linuxbrew"
#export HOMEBREW_CELLAR="$HOME/.linuxbrew/Cellar"
#export HOMEBREW_REPOSITORY="$HOME/.linuxbrew/Homebrew"
#export HOMEBREW_SHELLENV_PREFIX="$HOME/.linuxbrew"
#export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin${PATH+:$PATH}"
#export MANPATH="$HOME/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
#export INFOPATH="$HOME/.linuxbrew/share/info:${INFOPATH:-}"
#export PATH="$HOME/.nodebrew/current/bin:$PATH}"
#export NODEBREW_ROOT="$HOME/.linuxbrew/var/nodebrew"

#----------------------
# nodejs
#----------------------
export NVM_DIR="$(readlink -f $HOME)/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#----------------------
# asdf
#----------------------
ASDF_DIR=$HOME/.asdf
[ -f ${ASDF_DIR}/asdf.sh ] && {
    source ${ASDF_DIR}/asdf.sh
    fpath=(${ASDF_DIR}/completions $fpath)
    autoload -Uz compinit && compinit
}

#----------------------
# zplug start
#----------------------
if [ -d ~/.zplug ]; then
  source ~/.zplug/init.zsh

  #-----------------------------
  # zsh-syntax-highlighting
  #-----------------------------
  zplug "zsh-users/zsh-syntax-highlighting", defer:2

  #-----------------------------
  # zsh-autosuggestions
  #-----------------------------
  zplug "zsh-users/zsh-autosuggestions", defer:2

  #-----------------------------
  # zsh-completions
  #-----------------------------
  zplug "zsh-users/zsh-completions", defer:2

  #-----------------------------
  # fzf-tab
  #-----------------------------
  zplug "Aloxaf/fzf-tab", defer:2

  #-----------------------------
  # zsh-vi-mode
  #-----------------------------
  zplug "jeffreytse/zsh-vi-mode"
  export KEYTIMEOUT=1
  export ZVM_VI_ESCAPE_BINDKEY="^J"

  function zle-keymap-select {
    case $KEYMAP in
      vicmd)      ZVM_MODE_INDICATOR="%F{yellow}[N]%f" ;;
      main|viins) ZVM_MODE_INDICATOR="%F{green}[I]%f" ;;
      *)          ZVM_MODE_INDICATOR="%F{red}[?]%f" ;;
    esac
    zle reset-prompt
  }

  zle -N zle-keymap-select

  PROMPT='
${ZVM_MODE_INDICATOR} %B%{${fg[red]}%}[%n%{${fg[blue]}%}@%m${WINDOW:+":$WINDOW"}]%{%(?.$fg[blue].$fg[red])%}${vcs_info_msg_0_} [%~]
%(!.#.$)%{${reset_color}%}%b '




  # プラグインの定義例
  #zplug "zsh-users/zsh-history-substring-search"
  #zplug "zsh-users/zsh-syntax-highlighting"
  #zplug "zsh-users/zsh-autosuggestions"

  # プラグインのインストール確認とインストール
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi

  # プラグインの読み込み
  zplug load

  zvm_bindkey vicmd '^]' fzf-cd
  zvm_bindkey viins '^]' fzf-cd
  zvm_bindkey vicmd '^o' __cd_up
  zvm_bindkey viins '^o' __cd_up
  zvm_bindkey viins '^d' delete-char

  bindkey -v
fi

#----------------------
# zplug end
#----------------------


#----------------------
# powerlevel10k
#----------------------
[[ -f ~/.powerlevel10k/powerlevel10k.zsh-theme ]] && source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

source ~/.aliasrc
source ~/.zshrc_func
source ~/.zshrc_after
