#!/bin/bash

DOTFILES=(
.gitconfig
.tmux.conf
.vimrc
.zshrc
.vim
.vrapperrc
.lesskey
.my_tools
)

function remove_dotfiles() {
    for dotfile in ${DOTFILES[@]}
    do
        rm -rf $HOME/$dotfile
    done
}

function mk_dotfiles_link() {
    for dotfile in ${DOTFILES[@]}
    do
        ln -s $PWD/$dotfile $HOME/$dotfile
    done
}

function setup_lesskey() {
    cd $HOME
    lesskey
}

function add_exec_perm() {
    chmod +x .my_tools/*
}

function main() {
    remove_dotfiles
    mk_dotfiles_link
    setup_lesskey
    add_exec_perm
}

main
