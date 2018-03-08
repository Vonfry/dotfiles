echo_info "* system is Darwin"
echo_info "** setup brew and a lot of software"
# cmd line tools
sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
cd "$(brew --repo)"/Library/Taps/caskroom/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

brew update && brew upgrade
brew install caskroom/cask/brew-cask

# shell
brew tap beeftornado/rmtree # rm pkg with deps
brew install gnu-sed gnu-tar unzip unrar
brew cask install gpg-suite
brew install zsh wget git git-extras git-flow tig
brew install fzf && /usr/local/opt/fzf/install
brew install thefuck
brew install autojump
brew install googler
# brew install htop
brew install lolcat                        # colorful print
brew install cloc                          # code statistics
brew install tree uchardet                 # file browser
brew install colordiff
brew install fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew install handbrake                     # video transcoder

# C & Cpp libs
brew install gcc --with-nls
brew install llvm --with-lldb --with-graphviz --with-toolchain # This is a dependence for other app(i.e. rtags), and use it insteaded of system llvm(xcode).
brew install scons # a cross build tools
brew install gdb --with-all-targets --with-python
brew install cmake --with-completion
brew install ninja
brew install boost zlib libffi
brew install boost-python3

# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags
brew install global --with-ctags --with-pygments --with-sqlite3
brew install rtags --without-emacs
brew install cscope
brew install doxygen --with-doxywizard --with-graphviz
brew install cflow

# code search
brew install ack the_silver_searcher awk gawk

# lang
brew install ghc
brew install cabal-install haskell-stack
brew install ruby
brew install rbenv
brew install clisp sbcl
brew install ocaml opam
brew install python3
brew install python
brew install go node
brew install sqlite mysql postgresql redis # database
brew install poppler                       # pdf generator
brew install pandoc                        # markdown
brew cask install mactex                   # providing tex basic tools
brew cask install texpad                   # a tex ide
brew cask install java
brew install ispell                        # emacs flyspell dependency
brew install shellcheck

# system tool
brew install wireshark --with-nghttp2 --iwth-headers --with-libssh --with-qt # web package catch
brew cask install docker
brew cask install amethyst # a tool like xmonad
brew install graphviz --with-app

# chat
brew cask install gitter
brew install weechat

# editor
brew install editorconfig
brew install macvim --with-lua --with-override-system-vim --with-luajit
brew install neovim
brew install emacs --with-cocoa --with-gnutls --with-imagemagick@6 --with-librsvg --with-mailutils --with-dbus
# TODO change imagemagick@6 to other version
# TODO use emacs-port instead of gnu-emacs until it supports with multi-tty
# brew tap railwaycat/emacsmacport
# brew install emacs-mac --with-glib --with-gnutls --with-modern-icon --with-natural-title-bar --with-xml2 --with-imagemagick\n
sudo ln -f -s $script_dir/etc/motd /etc/motd

# life
brew cask install iina # video
brew install axel # http download
brew cask install deluge # torrent
brew cask install intel-power-gadget # cpu monitor
brew cask install sigil # epub editor

# quicklook
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo
brew cask install provisionql
brew cask install quicklook-pat

# My emacs cunfigure has a auto-upgrade everytime opening it, so start it by ourselves is possibly better.
brew services start emacs
brew services start rtags

sudo tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
