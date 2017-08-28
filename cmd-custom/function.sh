function vonfry-update()
{
    upgrade_oh_my_zsh
    case "$(uname)" in
        "Darwin")
            brew update
            brew upgrade
            brew cleanup
            echo "You may run /usr/local/opt/fzf/install to install fzf"
            ;;
        # if ctags is updated, emacs needs being recompiled.
        "Linux")
            source /etc/os-release
            case "$ID" in
                "fedora")
                    sudo dnf clean all
                    sudo dnf update -y
                    sudo dnf clean all
                    ;;
                "gentoo")
                    emerge-webrsync
                    emerge -uDU --with-bdeps=y @world
                    ;;
            esac
            ;;
    esac
    if command -v zplug >/dev/null 2>&1; then
        zplug update
    fi
    print "\e[31m Make sure the python url is needed to be rewriten in emacs configure. \033[0m"
    cabal update
    cat $DOTFILES_DIR/cabal.txt | xargs -t -n1 cabal install # update cabal installed package
    stack upgrade
    hoogle generate
    pip3 install -U -r ~/.pip3.txt
    pip2 install -U -r ~/.pip2.txt
    gem update && gem update --system
    gem cleanup
    npm update -g

    vim -c "execute \"PluginUpdate\" | qa"
    if [ "$(uname)" = Darwin ]; then
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang
    else
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer
    fi
    cd ~/.vim/bundle/vimproc.vim/ && make && cd -
}
