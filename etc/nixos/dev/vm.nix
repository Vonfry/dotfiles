{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark-cli
    docker
    docker_compose
  ];

  virtualisation = {
    virtualbox.host.enable = true;
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };

}
