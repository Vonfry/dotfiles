{ config, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    tmux.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git git-lfs
    zsh fzf
    file patch colordiff tmux
    zip unzip
    ripgrep fd exa bat
  ];
}
