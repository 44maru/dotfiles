umask 022

#source $HOME/.bash_profile

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

export TERM=xterm-color


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

alias sourcezsh='source ~/.zshrc'

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
alias gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
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
    echo $url
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
#RPROMPT='%{${fg[green]}%}[%(5~,%-1~/.../%2~,%~)] %{${fg[magenta]}%}%B%T%b%{${reset_color}%} $(parse_git_branch)'
#SPROMPT="%B%r is correct? [n,y,a,e]:%b "


#PROMPT="%n@%m%% "
RPROMPT="[%~]"
SPROMPT="correct: %R -> %r ? "


typeset -ga chpwd_functions

function _toriaezu_ls() {
ls -v -F --color=auto
}

function _change_rprompt {
if [ $PWD = $HOME ]; then
  RPROMPT="[%T]"
else
  RPROMPT="%{$fg_bold[white]%}[%{$reset_color%}%{$fg[cyan]%}%60<..<%~%{$reset_color%}%{$fg_bold[white]%}]%{$reset_color%}"
fi
}

export PATH=$HOME/.my_tools:$PATH

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
fi

alias kc='kubectl'

#-----------------------------------------------
# ghq(GO)
#-----------------------------------------------
export GHQPATH=$HOME/dev/go
export PATH=$GHQPATH/bin:$PATH

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
bindkey '^W' peco-cdr
