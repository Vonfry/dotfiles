{ config, pkgs, ... }:

let
  localFiles = with builtins; with lib;
    map (n: ./local + "/${n}")
        (attrNames (filterAttrs
                   (n: v: v != "directory" && isList (match "^.*\\.nix$" n))
                   (readDir ./local)));
in {
  users.users.vonfry = {
    isNormalUser = true;
    home = "/home/vonfry";
    description = "Vonfry";
    extraGroups = [ "wheel" "docker" "vboxusers" ];
    shell = pkgs.zsh;
  };
  imports = [ ] ++ localFiles;
  home-manager.users.vonfry = import ./home.nix;
}
