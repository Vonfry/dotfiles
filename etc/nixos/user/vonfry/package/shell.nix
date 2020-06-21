{ pkgs, ... }:

with pkgs;
[ wget curl
  git git-lfs
  zsh gnupg
  atop htop
  file
  fzf
  colordiff
  tmux
  w3m
  patch
  zip unzip
  lm_sensors lsof
  ripgrep
  gawk
  fd
  exa
  bat
  procs

  gitAndTools.gitflow tig gitAndTools.git-extras
  zsh fzf
  direnv thefuck
  lorri
  ranger
  parallel
  lolcat
  fortune cmatrix figlet
  asciinema
  neofetch
] ++ lib.optional (!stdenv.isDarwin)
[ flameshot
  alacritty
] ++ lib.optional stdenv.isDarwin
[ terminal-notify
]
