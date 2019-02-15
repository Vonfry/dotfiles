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
brew reinstall git
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
brew reinstall direnv
brew reinstall ranger

# C & Cpp libs
brew reinstall gcc
brew reinstall llvm
brew reinstall gdb
brew reinstall binutils
brew reinstall cmake
brew reinstall ninja
brew reinstall zlib libffi

# C & Cpp developing tools
brew cask install doxygen

# code search
brew reinstall the_silver_searcher gawk
brew reinstall cloc                          # code statistics

# lang
brew reinstall ghc
brew reinstall cabal-install
brew reinstall ruby
brew reinstall rbenv
brew reinstall python
brew reinstall node
brew reinstall sqlite mysql postgresql redis # database
brew reinstall poppler                       # pdf generator
brew reinstall pandoc                        # markdown
brew cask install mactex                     # providing tex basic tools
brew cask install java
brew reinstall shellcheck
brew reinstall shfmt
brew reinstall yq

# system tool
brew cask install wireshark
brew cask install docker
brew reinstall graphviz
brew reinstall gnuplot

# chat
brew reinstall weechat
brew reinstall mutt
brew reinstall hub

# editor
brew reinstall editorconfig
brew reinstall neovim
brew reinstall emacs
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
