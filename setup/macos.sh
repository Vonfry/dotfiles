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
brew reinstall gnu-sed gnu-tar unzip unrar
brew cask install gpg-suite
brew reinstall git --with-gettext --with-openssl --with-curl --with-blk-sha1
brew reinstall zsh wget git-flow tig
brew reinstall fzf && /usr/local/opt/fzf/install
brew reinstall thefuck
brew reinstall autojump
brew reinstall googler
# brew reinstall htop
brew reinstall lolcat                        # colorful print
brew reinstall cloc                          # code statistics
brew reinstall tree uchardet                 # file browser
brew reinstall colordiff
brew reinstall fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew reinstall handbrake                     # video transcoder
brew reinstall parallel
brew reinstall gpatch
brew reinstall tmux

# C & Cpp libs
brew reinstall gcc --with-nls
brew reinstall llvm --with-lldb --with-graphviz --with-toolchain # This is a dependence for other app(i.e. rtags), and use it insteaded of system llvm(xcode).
brew reinstall scons # a cross build tools
brew reinstall gdb --with-all-targets --with-python
brew reinstall cmake --with-completion
brew reinstall ninja
brew reinstall boost zlib libffi
brew reinstall boost-python3

# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew reinstall --HEAD universal-ctags
brew reinstall global --with-ctags --with-pygments --with-sqlite3
brew reinstall rtags --without-emacs
brew reinstall cscope
brew reinstall doxygen --with-doxywizard --with-graphviz
brew reinstall cflow

# code search
brew reinstall ack the_silver_searcher awk gawk

# lang
brew reinstall ghc
brew reinstall cabal-install haskell-stack
brew reinstall ruby
brew reinstall rbenv
brew reinstall clisp sbcl
brew reinstall ocaml opam
brew reinstall python3
brew reinstall python
brew reinstall go node
brew reinstall sqlite mysql postgresql redis # database
brew reinstall poppler                       # pdf generator
brew reinstall pandoc                        # markdown
brew cask install mactex                   # providing tex basic tools
brew cask install texpad                   # a tex ide
brew cask install java
brew reinstall ispell                        # emacs flyspell dependency
brew reinstall shellcheck

# system tool
brew cask install xquartz
brew reinstall wireshark --with-nghttp2 --iwth-headers --with-libssh --with-qt # web package catch
brew cask install docker
brew reinstall graphviz --with-app
brew reinstall gnuplot --with-x11

# chat
brew cask install gitter
brew reinstall weechat

# editor
brew reinstall editorconfig
brew reinstall macvim --with-lua --with-override-system-vim --with-luajit
brew reinstall neovim
brew reinstall emacs --with-cocoa --with-gnutls --with-imagemagick@6 --with-librsvg --with-mailutils --with-dbus
# TODO change imagemagick@6 to other version
# TODO use emacs-port instead of gnu-emacs until it supports with multi-tty
# brew tap railwaycat/emacsmacport
# brew install emacs-mac --with-glib --with-gnutls --with-modern-icon --with-natural-title-bar --with-xml2 --with-imagemagick\n
sudo ln -f -s $script_dir/etc/motd /etc/motd

# life
brew cask install iina # video
brew reinstall axel # http download
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
