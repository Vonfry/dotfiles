if [ "$(uname)" = Darwin ]; then
    echo_sh "* system is Darwin"
    echo_sh "** setup brew and a lot of software"
    sudo chown $(whoami) -R /usr/local/share/man
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update && brew update && brew upgrade
    brew install zsh wget git git-extras tig
    brew install fzf && /usr/local/opt/fzf/install
    brew install gcc cmake
    brew install llvm --universal --with-python --with-clang
    brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags
    brew install global --with-ctags --with-pygments --with-sqlite3
    brew install cscope codequery
    brew install doxygen --with-doxywizard
    brew install caskroom/cask/brew-cask
    brew install ack the_silver_searcher
    brew install go node
    brew install python3 python
    brew install ruby ----universal
    brew install cloc
    brew install tree uchardet
    brew install clisp sbcl
    brew install ghc cabal-install haskell-stack
    brew install wireshark
    brew install thefuck
    brew install sqlite mysql postgresql redis
    brew install graphviz
    brew install poppler automake
    brew install emacs --with-cocoa --with-gnutls --with-imagemagick --with-librsvg --with-mailutils --with-modules --devel
    brew linkapp emacs
    brew install Homebrew/emacs/irony-mode
    brew install smartypants
    brew install fortune cmatrix figlet # 诗词，代码雨，ascii-art
    brew install pandoc
    brew cask install mactex
    brew cask install arduino
    brew cask install java
    brew cask install xquartz
    brew cask install gitter
    brew tap macvim-dev/macvim && brew install --HEAD macvim-dev/macvim/macvim
    brew install neovim/neovim/neovim
    brew install autojump
    brew install googler
    brew install poco boost thrift swig
    brew install boost_python --with-python3
    sudo ln -f -s $script_dir/motd /etc/motd
else
    echo_sh "WARNING: NOT Darwin"
fi
