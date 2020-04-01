{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv thefuck
  lorri
  ranger
  parallel
  mu isync
  rclone
  vdirsyncerStable khard khal
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]
