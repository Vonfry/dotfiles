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
    htop
    tree
    file
    fzf
    colordiff
    tmux
    lynx
    patch
    unzip
    lm_sensors
    ripgrep
    gawk
    fd
  ];
}
