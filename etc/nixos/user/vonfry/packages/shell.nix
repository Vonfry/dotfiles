{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  gitAndTools.hub
  zsh fzf
  direnv
  autojump
  thefuck
  ranger
  parallel
  weechat
  mutt msmtp offlineimap
  googler
  lolcat
  fortune cmatrix figlet
  unstable.dropbox-cli
  asciinema
  flameshot
  neofetch
]
