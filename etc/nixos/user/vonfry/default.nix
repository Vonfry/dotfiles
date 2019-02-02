{ config, pkgs, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };
  imports = with import (dirOf <nixos-config> + /libs);
    let localFiles = matchFiles ./. "default\\.local\\.nix" [];
    in mergeList localFiles [ ./packages ];
}
