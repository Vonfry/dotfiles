echo_sh "* system is Darwin"
echo_sh "** setup brew and a lot of software"
# cmd line tools
sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade
brew install caskroom/cask/brew-cask
brew install zsh wget git git-extras tig
brew install fzf && /usr/local/opt/fzf/install
brew install thefuck
brew install autojump
brew install googler
brew install lolcat        # colorful print
brew install cloc          # code statistics
brew install tree uchardet # file browser
# C & Cpp libs
brew install gcc --with-jit --with-nls
brew install llvm --with-graphviz --with-lldb --with-ocaml --with-python --with-shared-libs --with-toolchain # This is a dependence for other app(i.e. rtags), and use it insteaded of system llvm(xcode).
brew install gdb --with-all-targets --with-python
brew install cmake --with-completion
brew install automake
brew install poco boost thrift swig
brew install boost-python --with-python3
# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags
brew install global --with-ctags --with-pygments --with-sqlite3
brew install rtags
brew install cscope
brew install doxygen --with-doxywizard
# code search
brew install ack the_silver_searcher
# lang
brew install ghc cabal-install haskell-stack
brew install python3 python
brew install ruby ----universal
brew install rbenv
brew install clisp sbcl
brew install go node
brew install graphviz                      # dot lang to png
brew install sqlite mysql postgresql redis # database
brew install poppler                       # pdf generator
brew install wireshark                     # web package catch
brew install fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew install pandoc                        # markdown
brew cask install mactex
brew cask install arduino
brew cask install java
brew cask install xquartz
# chat
brew cask install gitter
# editor
brew tap macvim-dev/macvim && brew install --HEAD macvim-dev/macvim/macvim
brew install neovim
brew install emacs --with-cocoa --with-gnutls --with-imagemagick --with-librsvg --with-mailutils --with-modules --HEAD
sudo ln -f -s $script_dir/motd /etc/motd

# quicklook
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo
brew cask install provisionql
brew cask install quicklook-pat

echo_sh "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
