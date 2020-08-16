{ config, pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    tmux.enable = true;
  };

  environment.systemPackages = with pkgs; [
    zsh fzf
    tmux
  ];
}
