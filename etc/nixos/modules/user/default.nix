{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  imports = [ <home-manager/nixos> ];

  config = mkIf cfg.enable {
    users.motd = builtins.readFile ./motd;

    users.users.vonfry = {
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ];
      shell = pkgs.zsh;
    };

    home-manager = {
      users.vonfry = import ./home.nix;
      useUserPackages = true;
    };
  };
}
