{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  imports = [ <home-manager/nixos> ];

  options.vonfry = {
    user.extraConfig = mkOption {
      default = { };
      example = { openssh.authorizedKeys.keys = [ ]; };
      description = "User extra config.";
      type = types.attrs;
    };

    hmConfig = mkOption {
      default = _: {};
      description = "home-manager config.";
    };
  };

  config =
    let
      vonfryHome = "/home/vonfry";
    in  mkIf cfg.enable {
    users.motd = builtins.readFile ./files/motd;

    users.users.vonfry = mkMerge [{
      isNormalUser = true;
      home = vonfryHome;
      description = "Vonfry";
      extraGroups = [ "wheel" "docker" "libvirtd" "networkmanager" "syncthing"
                    ];
      shell = pkgs.zsh;
    } cfg.user.extraConfig];

    home-manager = {
      useUserPackages = true;
      users.vonfry = mkMerge [
        (args:
        {
          imports = [ ./home.nix ];

          vonfry = mkDefault {
            inherit (cfg) enable;
          };
        })
        cfg.hmConfig
      ];
    };

    vonfry.network.syncthing.folders = {
      "${vonfryHome}/cloud" = {
        versioning = {
          params = { keep = "5"; };
          type = "simple";
          ignorePerms = false;
        };
      };
    };
  };
}
