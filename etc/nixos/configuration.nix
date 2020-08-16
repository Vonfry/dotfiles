{ config, pkgs, lib, ... }:

let
  localFiles =  with builtins; with lib;
    map (n: ./local + "/${n}")
        (attrNames (filterAttrs
                   (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                   (readDir ./local)));
in {
  imports = [
    ./hardware-configuration.nix # use `nixos-generate-config`
    ./base.nix
    ./network.nix
    ./shell.nix
    ./development.nix
    ./x.nix
    ./misc.nix
    ./user
  ] ++ localFiles;

  lib = pkgs.callPackage ./lib { };
}
