{ config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [ 
    wireshark-cli 
    docker
    docker_compose
  ];

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };
}
