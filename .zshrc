umask 022

source $HOME/.bash_profile

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
alias dstat-mem='dstat -Ttclms'
alias dstat-cpu='dstat -Ttclr'
alias dstat-net='dstat -Ttclnd'
alias dstat-disk='dstat -Ttcldrs'


setopt prompt_subst

#PROMPT='%B%{${fg[red]}%}[%n%{${fg[blue]}%}@%m${WINDOW:+":$WINDOW"}]%{%(?.$fg[blue].$fg[red])%}%(!.#.$)%{${reset_color}%}%b '
#RPROMPT='%{${fg[green]}%}[%(5~,%-1~/.../%2~,%~)] %{${fg[magenta]}%}%B%T%b%{${reset_color}%} $(parse_git_branch)'
#SPROMPT="%B%r is correct? [n,y,a,e]:%b "

PROMPT="%n@%m%% "
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

#-----------------------------------------------
# Python setting
#-----------------------------------------------
export PYTHONUSERBASE=$HOME/local
export PATH=$PATH:$HOME/local

#-----------------------------------------------
# kubectl
#-----------------------------------------------
if [ -f /usr/bin/kubectl ]; then
    source <(kubectl completion zsh)
fi

