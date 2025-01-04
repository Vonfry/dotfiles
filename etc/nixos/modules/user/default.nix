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

    sops.secrets.${cfg.secretsName.password}.neededForUsers = true;

    users.users.vonfry = {
      isNormalUser = true;
      uid = mkDefault 1000;
      description = "Vonfry";
      extraGroups = [
        "wheel"
        "libvirtd"
      ];
      shell = pkgs.bash;

      hashedPasswordFile = config.sops.secrets.${cfg.secretsName.password}.path;
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
  options.vonfry = {
    secretsName.password = mkOption {
      description = "The sops key for password.";
      type = types.nonEmptyStr;
      default = "${config.users.users.vonfry.name}-password";
    };
  };

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
    ./impermanence.nix
    ./definitions.nix
  ];

  config = mkMerge [
    (mkIf cfg.enable userconfig)
    (mkIf cfg.x.enable xconfig)
  ];
}
