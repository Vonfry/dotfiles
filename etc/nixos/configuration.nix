{ config, pkgs, lib, ... }:

let
  localFiles =  with builtins; with lib;
    map (n: ./local + "/${n}")
        (attrNames (filterAttrs 
                   (n: v: v == "regular" && isList (match "^.*\\.nix$" n))
                   (readDir ./local)));
in {
  imports = [
    ./hardware-configuration.nix # use `nixos-generate-config`
    ./lib
    ./base.nix
    ./network.nix
    ./shell.nix
    ./editor.nix
    ./development.nix
    ./x.nix
    ./misc.nix
    ./user
    
  ] ++ localFiles;
}
