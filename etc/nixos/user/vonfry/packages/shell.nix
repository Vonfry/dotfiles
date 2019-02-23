{ pkgs, ... }:

with pkgs; [
  gitAndTools.gitflow tig gitAndTools.git-extras
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
  mutt msmtp offlineimap
  googler
  lolcat
  fortune cmatrix figlet
  dropbox-cli
]
