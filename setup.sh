#!/bin/bash

DOTFILES=$(ls -d .?* | grep -v "\.git$" | grep -v "\.config$" | grep -v "^\.$" | grep -v "^\.\.$" | grep -v "\.swp$")

# .configのようなシステム側でもファイルを作成するディレクトリは、その配下にリンクを作成したいので、ここで定義する
SUB_DOT_DIRS=(
    .config
)

function mk_dotfiles_link() {
    for dotfile in ${DOTFILES[@]}; do
        rm -rf $HOME/$dotfile
        ln -s $PWD/$dotfile $HOME/$dotfile
    done

    for sub_dot_dir in ${SUB_DOT_DIRS[@]}; do
        mkdir -p $HOME/$sub_dot_dir/$dotfile
        dotfiles=$(ls -a $sub_dot_dir | grep -v "\.git$" | grep -v "^\.$" | grep -v "^\.\.$" | grep -v "\.swp$")
        for dotfile in ${dotfiles[@]}; do
            rm -rf $HOME/$sub_dot_dir/$dotfile
            ln -s $PWD/$sub_dot_dir/$dotfile $HOME/$sub_dot_dir/$dotfile
        done
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
        pip3 install --user "pydantic==1.8.2"
        pip3 install --user jedi-language-server
    }
}

function install_go_modules() {
    test -e /usr/bin/go && {
        echo "=== install ghq ==="
        go install github.com/x-motemen/ghq@latest
        echo "=== install goimports ==="
        go install golang.org/x/tools/cmd/goimports@latest
        echo "=== install gopls ==="
        go install golang.org/x/tools/gopls@latest
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

function install_nodejs() {
    which nvm >/dev/null || {
        echo "=== install nvm ==="
        curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh -o /tmp/install_nvm.sh
        bash /tmp/install_nvm.sh
        export NVM_DIR="${HOME}/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && source "${NVM_DIR}/nvm.sh"                   # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && source "${NVM_DIR}/bash_completion" # This loads nvm bash_completion
        nvm install --lts
    }
}

function install_asdf() {
    which asdf >/dev/null || {
        echo "=== install asdf ==="
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    }
}

function install_lsp() {
    which npm >/dev/null && {
        echo "=== install LSP (npm i -g bash-language-server) ==="
        npm i -g bash-language-server
    }
}

function install_utility_modules() {
    install_python_modules
    install_go_modules
    install_fzf
    install_asdf
    install_nodejs
    install_lsp
    #install_linuxbrew

    # https://askubuntu.com/questions/1290262/unable-to-install-bat-error-trying-to-overwrite-usr-crates2-json-which
    # sudo apt install --fix-broken -o Dpkg::Options::="--force-overwrite" ripgrep bat
}

function setup_nvim() {
    echo "=== setup nvim ==="
    curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o "${HOME}/.my_tools/nvim"
    chmod +x "${HOME}/.my_tools/nvim"

    mkdir -p "${HOME}/.config/nvim"
    cd "${HOME}/.config/nvim/" || exit 1
    rm -f init.vim ftplugin
    ln -s "${HOME}/.vimrc" init.vim
    ln -s "${HOME}/.vim/ftplugin" .
}

function main() {
    mk_dotfiles_link
    mk_ssh_config
    setup_lesskey
    install_utility_modules
    setup_nvim
}

main
