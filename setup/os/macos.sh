echo_info "* system is Darwin"
echo_info "** setup brew and a lot of software"
echo_info "-- Please make sure you have installed xcode and run xcode-select --install; open open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_<version>.pkg"
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
brew reinstall tree                          # file browser
brew reinstall colordiff
brew reinstall fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew reinstall handbrake                     # video transcoder
brew reinstall parallel
brew reinstall gpatch
brew reinstall tmux
brew reinstall most
brew reinstall direnv
brew reinstall ranger

# C & Cpp libs
brew reinstall gcc --with-nls
brew reinstall llvm --with-lldb --with-graphviz --with-toolchain
brew reinstall gdb --with-all-targets --with-python
brew reinstall binutils
brew reinstall cmake --with-completion
brew reinstall ninja
brew reinstall boost zlib libffi
brew reinstall boost-python3

# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew reinstall --HEAD universal-ctags
brew cask install doxygen

# code search
brew reinstall the_silver_searcher gawk
brew reinstall cloc                          # code statistics

# lang
brew reinstall ghc
brew reinstall cabal-install haskell-stack
brew reinstall ruby
brew reinstall rbenv
brew reinstall r libomp                      # libomp is required for a packages
brew reinstall python3
brew reinstall python
brew reinstall node
brew reinstall sqlite mysql postgresql redis # database
brew reinstall poppler                       # pdf generator
brew reinstall pandoc                        # markdown
brew cask install mactex                     # providing tex basic tools
brew cask install java
brew reinstall shellcheck
brew reinstall shfmt

# system tool
brew cask install xquartz
brew cask install wireshark
brew cask install docker
brew reinstall graphviz --with-app
brew reinstall gnuplot --with-x11

# chat
brew cask install gitter
brew reinstall weechat
brew reinstall mutt

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

echo_info "*** install nix for macos"
sh <(curl https://nixos.org/nix/install)

# brew services start emacs
# Macos launch isn't use the same shell with user, which cannot work correctly with exec-path-from-shell-path.

# variable
echo "export HOMEBREW_OPT_INIT_FUNCTION=()" >> $script_dir/config/shell/defvar.sh

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
