echo_info "* system packages: brew and others"
echo_info "-- Please make sure you have installed xcode and run xcode-select --install; open open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_<version>.pkg"
# cmd line tools
sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update && brew upgrade
brew install caskroom/cask/brew-cask

# shell
brew install gnu-sed gnu-tar unzip unrar
brew cask install the-unarchiver
brew cask install gpg-suite
brew install git
brew install zsh wget git-flow tig
brew cask install alacritty
brew reinstall fzf && /usr/local/opt/fzf/install
brew reinstall dbus
brew reinstall thefuck
# brew reinstall htop
brew reinstall lolcat                        # colorful print
brew reinstall colordiff
brew reinstall fortune cmatrix figlet        # 诗词，代码雨，ascii-art
brew reinstall handbrake                     # video transcoder
brew reinstall parallel
brew reinstall gpatch
brew reinstall tmux
brew reinstall direnv
brew reinstall ranger
brew reinstall w3m
brew reinstall isync
brew reinstall procs

# C & Cpp libs
brew install gcc
brew install llvm
brew install gdb
brew install binutils
brew install cmake
brew install ninja
brew install zlib libffi

# C & Cpp developing tools
brew cask install doxygen

# code search
brew install ripgrep gawk fd exa bat
brew install cloc                          # code statistics

# lang
brew install ruby
brew install rbenv
brew install python
brew install node
brew install sqlite mysql postgresql redis # database
brew install pgcli mycli
brew install poppler                       # pdf generator
brew install pandoc                        # markdown
brew cask install java

# system tool
brew cask install wireshark
brew cask install docker
brew install graphviz
brew install gnuplot
brew install asciinema httpstat
brew install terminal-notifier

# editor
brew install editorconfig
brew install neovim
brew tap d12frosted/emacs-plus
brew install emacs-plus --with-dbus
sudo ln -f -s $script_dir/etc/motd /etc/motd

# life
brew cask install squirrel
brew cask install iina # video
brew cask install qbittorrent
brew cask install intel-power-gadget # cpu monitor
brew cask install sigil # epub editor
brew cask install amethyst
brew cask install mactex
brew cask install firefox

# font
brew cask install font-hack
brew cask install font-symbola

echo_info "*** install nix for macos"
sh <(curl https://nixos.org/nix/install)

# config
ln -sf $script_dir/config/rime/* ~/Library/Rime

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
