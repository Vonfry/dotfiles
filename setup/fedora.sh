if [ "$(uname)" = Linux ]; then
    source /etc/os-release
    if [ "$(ID)" = fedora ]; then
        sudo dnf update -y && sudo dnf upgrade -y
        sudo dnf install -y zsh
        sudo dnf install -y wget git git-extra tig screen
        sudo dnf install -y cmake gcc clang llvm
        sudo dnf install -y tree uchardet
        sudo dnf install -y ack the_silver_searcher
        sudo dnf install -y global
        sudo dnf install -y sbcl gcl clisp
        sudo dnf install -y ghc cabal-install
        sudo dnf copr enable petersen/stack && sudo dnf install stack && dnf stack upgrade
        sudo dnf install -y httpd nginx
        sudo dnf install -y vim neovim emacs
        sudo dnf install -y python python-devel python3 python3-devel
        sudo dnf install -y ruby
        sudo dnf install -y go node
        sudo dnf install -y php php-devel
        sudo dnf install -y java
        sudo dnf install cloc
        sudo dnf install -y poco-devel boost thrift swig boost-python boost-python3
        sudo dnf install -y sqlite mariadb mariadb-server postgresql redis
        sudo dnf install -y sqlite-devel mariadb-devel postgresql-devel redis-devel
        sudo dnf install -y graphviz
        sudo dnf install -y doxygen
        sudo dnf install -y poppler automake
        sudo dnf install -y arduino
        sudo dnf install -y docker
        sudo dnf install -y youtube-dl aria2
        sudo ln -f -s $script_dir/issue /etc/issue

        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        echo_sh "INFO: NOT Fedora"
    fi
else
    echo_sh "WARNING: NOT Linux "
fi
