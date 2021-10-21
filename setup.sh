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
    which pip3 >/dev/null && {
        echo "install python modules"
        pip3 install --user autopep8
    }
}

function install_go_modules() {
    test -e /usr/bin/go && {
        echo "=== install ghq ==="
        go get -v github.com/motemen/ghq
        echo "=== install goimports ==="
        go get -v golang.org/x/tools/cmd/goimports
        echo "=== install gopls ==="
        go get -v golang.org/x/tools/gopls
    }
}

function mk_ssh_config() {
    mkdir -p ~/.ssh/tmp
    grep ControlMaster ~/.ssh/config >/dev/null || {
        echo "ControlMaster auto" >>~/.ssh/config
    }
    grep ControlPath ~/.ssh/config >/dev/null || {
        echo "ControlPath ~/.ssh/tmp/ssh_mux_%h_%p_%r" >>~/.ssh/config
    }
}

function install_fzf() {
    which fzf >/dev/null || {
        echo "=== install fzf ==="
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    }
}

function install_linuxbrew() {
    [ -f $HOME/.linuxbrew/bin/brew ] || {
        echo "=== install linuxbrew ==="
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    }
}

function install_utility_modules() {
    install_python_modules
    install_go_modules
    install_fzf
    #install_linuxbrew

    # https://askubuntu.com/questions/1290262/unable-to-install-bat-error-trying-to-overwrite-usr-crates2-json-which
    # sudo apt install --fix-broken -o Dpkg::Options::="--force-overwrite" ripgrep bat
}

function main() {
    remove_dotfiles
    mk_dotfiles_link
    mk_ssh_config
    setup_lesskey
    install_utility_modules
}

main
