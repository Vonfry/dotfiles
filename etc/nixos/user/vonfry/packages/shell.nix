{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  ranger
  parallel
  weechat
  msmtp offlineimap
  googler
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]
