{ config, pkgs, lib, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
  };
  imports = [ ./package ./local ];
}
