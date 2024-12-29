{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  userconfig = {
    users.motd = builtins.readFile ./files/motd;
    users.mutableUsers = false;

    users.users.vonfry = {
      isNormalUser = true;
      home = "/home/vonfry";
      uid = mkDefault 1000;
      description = "Vonfry";
      extraGroups = [
        "wheel"
        "libvirtd"
      ];
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

    # NixOS per-user profile also uses this.
    environment.pathsToLink = [ "/share/easyeffects" ];
  };

  xconfig = {
    services.xserver.desktopManager.wallpaper.mode = "center";
    # NixOS per-user profile also uses this.
    environment.pathsToLink = [ "/share/fcitx5" ];
  };
in
{

  imports = [
    (mkAliasOptionModule
      [
        "vonfry"
        "homeConfiguration"
      ]
      [
        "home-manager"
        "users"
        "vonfry"
      ]
    )
    (mkAliasOptionModule
      [
        "vonfry"
        "userConfiguration"
      ]
      [
        "users"
        "users"
        "vonfry"
      ]
    )
  ];

  config = mkMerge [
    (mkIf cfg.enable userconfig)
    (mkIf cfg.x.enable xconfig)
  ];
}
