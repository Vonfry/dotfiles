{ config, pkgs, ... }:

{
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = import ./pkgs pkgs;
  };
  imports = with import (dirOf <nixos-config> + /vonfry/libs);
    let localFiles = matchFiles ./. ".*\\.local\\.nix" [];
    in mergeList localFiles [ ];
}
