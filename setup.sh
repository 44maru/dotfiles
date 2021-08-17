#!/bin/bash

DOTFILES=$(ls -d .?* | grep -v "\.git$" | grep -v "^\.$" | grep -v "^\.\.$" | grep -v "\.swp$")

function remove_dotfiles() {
  for dotfile in ${DOTFILES[@]}; do
    rm -rf $HOME/$dotfile
  done
}

function mk_dotfiles_link() {
  for dotfile in ${DOTFILES[@]}; do
    ln -s $PWD/$dotfile $HOME/$dotfile
  done
}

function setup_lesskey() {
  cd $HOME
  lesskey
}

function install_python_modules() {
  echo "install python modules"
  pip3 install --user autopep8
}

function main() {
  remove_dotfiles
  mk_dotfiles_link
  setup_lesskey
  install_python_modules
}

main
