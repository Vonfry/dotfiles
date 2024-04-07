{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
  userconfig = {
    users.motd = builtins.readFile ./files/motd;

    users.users.vonfry = {
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      shell = pkgs.bash;
    };

    programs = {
      weylus.users = [ "vonfry" ];
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.vonfry = _: {
        imports = [ ./home.nix ];

        vonfry = {
          inherit (cfg) enable workspace;
        };
      };
    };
  };

  xconfig = {
    services.xserver.desktopManager.wallpaper.mode = "center";
  };
in {

  imports = [
    (mkAliasOptionModule
      [ "vonfry" "homeConfiguration" ]
      [ "home-manager" "users" "vonfry" ])
    (mkAliasOptionModule
      [ "vonfry" "userConfiguration" ]
      [ "users" "users" "vonfry" ])
  ];

  config = mkMerge [
    (mkIf cfg.enable userconfig)
    (mkIf cfg.x.enable xconfig)
  ];
}
