{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  ranger
  parallel
  mu unstable.offlineimap
  rclone
  vdirsyncerStable khard khal
  googler
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]
