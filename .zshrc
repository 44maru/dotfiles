umask 022

# disable diplay lock by ctrl+s
stty stop undef

#-----------------------------------------------
# Base setting
#-----------------------------------------------
#export LANG=ja_JP.utf8
export LANG=en_US.utf8
export EDITOR=vim
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
# alias
#-----------------------------------------------
alias ll='ls -lF --color'
alias la='ls -A --color'
alias ls='ls -CF --color'

alias grep='grep --color'

alias vimzsh='vim ~/.zshrc'
alias sourcezsh='source ~/.zshrc'

alias gs='git status'
alias gb='git --no-pager branch -a'
alias gd='git diff'
alias ga='git add'
alias gm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gcl='git clone'
alias gr='git restore'
alias gc='git clean -f .'
alias gcf='git branch -a | fzf | sed "s/*//" | sed "s%remotes/origin/%%" | xargs git checkout'

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

# move dir
#alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
alias dstat-full='dstat -Ttclmdrns'
alias dstat-cpu='dstat -Ttclr'
alias dstat-mem='dstat -Ttclms'
alias dstat-net='dstat -Ttcn --net-packets'
alias dstat-disk='dstat -Ttcldrs --top-io --top-bio'

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
PROMPT='%B%{${fg[red]}%}[%n%{${fg[blue]}%}@%m${WINDOW:+":$WINDOW"}]%{%(?.$fg[blue].$fg[red])%}${vcs_info_msg_0_}%(!.#.$)%{${reset_color}%}%b '

#PROMPT='%B%{${fg[red]}%}[%n%{${fg[blue]}%}@%m${WINDOW:+":$WINDOW"}]%{%(?.$fg[blue].$fg[red])%}%(!.#.$)%{${reset_color}%}%b '
#SPROMPT="%B%r is correct? [n,y,a,e]:%b "


#PROMPT="%n@%m%% "
#RPROMPT="[%~]"
SPROMPT="correct: %R -> %r ? "


typeset -ga chpwd_functions

export PATH=$HOME/.my_tools:$PATH

#-----------------------------------------------
# display current dir on tmux pane border
#-----------------------------------------------
function disp_current_dir_on_pane_border() {
  [ -v TMUX -o -v ON_TMUX  ] && {
      tmux select-pane -T ${PWD}
      type precmd > /dev/null 2>&1 && precmd
  }
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd disp_current_dir_on_pane_border

#-----------------------------------------------
# Python setting
#-----------------------------------------------
export PYTHONUSERBASE=$HOME/.python
export PATH=$PYTHONUSERBASE/bin:$PATH
export PIPENV_VENV_IN_PROJECT=true

#-----------------------------------------------
# kubectl
#-----------------------------------------------
if [ -f /usr/bin/kubectl ]; then
    source <(kubectl completion zsh)
    alias kc='kubectl'
    alias -g Y='-o yaml'
    alias -g J='-o json | jq .'
    [ -f /usr/bin/batcat ] && {
        alias -g Y='-o yaml | batcat --language yaml'
    }
fi

#-----------------------------------------------
# Golang
#-----------------------------------------------
export PATH=$HOME/go/bin:$PATH

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
    source ~/.fzf.zsh
    export FZF_DEFAULT_OPTS='--height 40% --reverse --border --ansi'
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
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
# bat
#-------------------
[ -f /usr/bin/batcat ] && {
    alias cat=batcat
}

#-------------------
# fd
#-------------------
[ -f /usr/bin/fdfind ] && {
    alias fd=fdfind
}

#-------------------
# Linuxbrew
#-------------------
#export HOMEBREW_PREFIX="$HOME/.linuxbrew";
#export HOMEBREW_CELLAR="$HOME/.linuxbrew/Cellar";
#export HOMEBREW_REPOSITORY="$HOME/.linuxbrew/Homebrew";
#export HOMEBREW_SHELLENV_PREFIX="$HOME/.linuxbrew";
#export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin${PATH+:$PATH}";
#export MANPATH="$HOME/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
#export INFOPATH="$HOME/.linuxbrew/share/info:${INFOPATH:-}";


source ~/.zshrc_func
source ~/.zshrc_after

