{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
  gitAndTools.diff-so-fancy
  zsh fzf
  direnv thefuck
  lorri
  ranger
  parallel
  lolcat
  fortune cmatrix figlet
  asciinema
  flameshot
  neofetch
]
