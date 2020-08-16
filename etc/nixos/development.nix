{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim neovim emacs

    cloc

    docker_compose # docker

    git git-lfs
  ];

  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };

  services.emacs.install = true;
}
