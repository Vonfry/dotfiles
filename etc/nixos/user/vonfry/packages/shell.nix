{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig
  gitAndTools.hub 
  zsh fzf
  direnv
  autojump
  thefuck
  htop
  tree
  ranger
  parallel
  colordiff
  tmux
  patch
  shellcheck
  unzip
  weechat
  mutt
  googler
  lolcat
  fortune cmatrix figlet
]
