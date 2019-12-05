{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  ranger
  parallel
  weechat
  mutt msmtp offlineimap
  vdirsyncerStable khard khal
  googler
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]