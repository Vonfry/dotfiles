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
brew install dbus
brew install thefuck

brew cask install java

# system tool
brew cask install docker

brew tap d12frosted/emacs-plus
brew install emacs-plus --with-dbus
sudo ln -f -s $script_dir/etc/motd /etc/motd

# life
brew cask install squirrel
brew cask install iina # video
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
