{ config, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    tmux.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wget curl
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
  ];
}
