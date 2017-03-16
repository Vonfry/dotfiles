if [ "$(uname)" == Linux ]; then
    source /etc/os-release
    if [ "$(ID)" == fedora ]; then
        sudo dnf update -y && sudo dnf upgrade -y
        sudo dnf install -y zsh
        sudo dnf install -y wget git git-extra screen
        sudo dnf install -y cmake gcc clang llvm
        sudo dnf install -y tree uchardet
        sudo dnf install -y ack the_silver_searcher
        sudo dnf install -y global
        sudo dnf install -y sbcl gcl clisp
        sudo dnf install -y ghc cabal-install
        sudo dnf install -y httpd nginx
        sudo dnf install -y vim neovim emacs
        sudo dnf install -y python python-devel python3 python3-devel
        sudo dnf install -y ruby
        sudo dnf install -y go node
        sudo dnf install -y php php-devel
        sudo dnf install -y java
        sudo dnf install -y poco boost thrift swig
        sudo dnf install -y sqlite mariadb mariadb-server postgresql redis
        sudo dnf install -y sqlite-devel mariadb-devel postgresql-devel redis-devel
        sudo dnf install -y graphviz
        sudo dnf install -y doxygen
        sudo dnf install -y poppler automake
        sudo dnf install -y arduino
        sudo dnf install -y docker
        sudo ln -f -s $script_dir/issue /etc/issue
    else
        echo_sh "INFO: NOT Fedora"
    fi
else
    echo_sh "WARNING: NOT Linux "
fi
