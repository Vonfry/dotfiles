{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cloc

    docker_compose # docker
  ];

  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };
}
