echo_info "* system packages: brew and others"
echo_info "-- Please make sure you have installed xcode and run xcode-select --install; open open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_<version>.pkg"
# cmd line tools

sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update && brew upgrade
brew install caskroom/cask/brew-cask

# shell
brew cask install the-unarchiver
brew cask install gpg-suite

# dev
brew cask install java
brew cask install docker

# life
brew cask install squirrel
brew cask install iina # video
brew cask install intel-power-gadget # cpu monitor
brew cask install sigil # epub editor
brew cask install amethyst
brew cask install mactex
brew cask install qutebrowser
brew cask install teleggram-desktop
brew cask install wireshark
brew cask install skim
brew cask install torbrowser

# font
brew cask install font-hack
brew cask install font-symbola

# config
sudo ln -f -s $script_dir/etc/motd /etc/motd

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
