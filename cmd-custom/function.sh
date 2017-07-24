function gitignore() { curl -L -s https://www.gitignore.io/api/$@ ;}

function vonfry-update()
{
    upgrade_oh_my_zsh
    case "$(uname)" in
        "Darwin")
            brew update
            brew upgrade
            brew cleanup
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
                    emaint -a sync
                    emerge-webrsync
                    eix-sync
                    emerge -uDU --with-bdeps=y @world
                    ;;
            esac
            ;;
    esac
    print "\e[31m Make sure the python url is needed to be rewriten in emacs configure. \033[0m"
    cabal update
    stack upgrade
    hoogle generate
    pip3 install -U -r ~/.pip3.txt
    pip2 install -U -r ~/.pip2.txt
    gem update && gem update --system
    gem cleanup
    npm update -g

    vundle-update
    if [ "$(uname)" = Darwin ]; then
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang
    else
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer
    fi
    cd ~/.vim/bundle/vimproc.vim/ && make && cd -

    emacs --eval "(package-list-packages)" # Then U-x
}

function jekyll-new-post()
{
    echo -n "input slug: "
    read slug
    postfile=$(date +%F)-$slug.md
    touch $postfile
    echo "---" > $postfile
    echo -n "input title: "
    read title
    echo "title: $title" >> $postfile
    echo "date: $(date "+%Y-%m-%d %H:%M:%S %z")" >> $postfile
    echo -n "input categories: "
    read categories
    echo "categories: $categories" >> $postfile
    echo -n "input tags: "
    read tags
    echo "tags: $tags" >> $postfile
    echo "---" >> $postfile
}

function codechecker-setup()
{
    source ~/codechecker/venv/bin/activate

    # Path of CodeChecker package
    # NOTE: SKIP this line if you want to always specify CodeChecker's full path
    export PATH=~/codechecker/build/CodeChecker/bin:$PATH

    # Path of `scan-build.py` (intercept-build)
    # NOTE: SKIP this line if you don't want to use intercept-build
    export PATH=~/{user path}/llvm/tools/clang/tools/scan-build-py/bin:$PATH

    # Path of the built LLVM/Clang
    # NOTE: SKIP this line if clang is available in your PATH as an installed Linux package
    export PATH=~/{user path}/build/bin:$PATH
}
