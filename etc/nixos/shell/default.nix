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

  services.offlineimap.install = true;

  environment.systemPackages = with pkgs; [
    wget curl
    git git-lfs
    zsh gnupg
    file
  ];
}
