echo_info "* system is Darwin"
echo_info "** setup brew and a lot of software"
# cmd line tools
sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

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
brew reinstall tree                          # file browser
brew reinstall colordiff
brew reinstall fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew reinstall handbrake                     # video transcoder
brew reinstall parallel
brew reinstall gpatch
brew reinstall tmux
brew reinstall most

# C & Cpp libs
brew reinstall gcc --with-nls
brew reinstall llvm --with-lldb --with-graphviz --with-toolchain
brew reinstall gdb --with-all-targets --with-python
brew reinstall cmake --with-completion
brew reinstall ninja
brew reinstall boost zlib libffi
brew reinstall boost-python3

# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew reinstall --HEAD universal-ctags
brew reinstall doxygen --with-doxywizard --with-graphviz

# code search
brew reinstall ack the_silver_searcher awk gawk

# lang
brew reinstall ghc
brew reinstall cabal-install haskell-stack
brew reinstall ruby
brew reinstall rbenv
brew reinstall clisp sbcl
brew reinstall ocaml opam
brew reinstall r libomp                      # libomp is required for a packages
brew reinstall python3
brew reinstall python
brew reinstall go node
brew reinstall sqlite mysql postgresql redis # database
brew reinstall poppler                       # pdf generator
brew reinstall pandoc                        # markdown
brew cask install mactex                     # providing tex basic tools
brew cask install texpad                     # a tex ide
brew cask install java
brew reinstall shellcheck
brew reinstall shfmt

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
brew reinstall macvim --with-override-system-vim
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
brew cask install mark-text

brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize webpquicklook suspicious-package quicklookase qlvideo

# brew services start emacs
# Macos launch isn't use the same shell with user, which cannot work correctly with exec-path-from-shell-path.

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
