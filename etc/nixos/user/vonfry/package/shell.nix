{ pkgs, ... }:

with pkgs; [
  wget curl
  git git-lfs
  zsh gnupg
  file
  fzf
  colordiff
  tmux
  w3m
  patch
  zip unzip
  ripgrep
  gawk
  fd
  exa
  bat
  procs

  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv
  thefuck
  lorri
  ranger
  parallel
  lolcat
  fortune cmatrix figlet
  asciinema
  neofetch
] ++ lib.optionals (!stdenv.isDarwin) [
  flameshot
  atop htop
  alacritty
  lm_sensors lsof
] ++ lib.optionals stdenv.isDarwin [
  terminal-notifier
]
