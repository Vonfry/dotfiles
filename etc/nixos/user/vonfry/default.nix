{ config, pkgs, lib, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
  };
  imports = with import <nixos-vonfry-lib>;
    let localFiles = matchFiles ./. "default\\.local\\.nix" [];
    in lib.lists.flatten [localFiles [ ./packages ]];
}
