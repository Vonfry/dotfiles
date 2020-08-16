{ config, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    tmux.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget curl
    git git-lfs
    zsh fzf
    sshfs file patch
    colordiff tmux
    w3m
    zip unzip
    ripgrep fd exa bat
  ];
}
