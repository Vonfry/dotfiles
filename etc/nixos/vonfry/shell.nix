{ config, pkgs, ... }:

{
  programs = { 
    zsh.enable = true;
    tmux.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = false; # pam ssh auth will manage one
    };
  };

  environment.systemPackages = with pkgs; [
    wget curl 
    git git-lfs 
    zsh gnupg
  ];
}
