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

  config = mkIf cfg.enable {
    users.motd = builtins.readFile ./files/motd;

    users.users.vonfry = mkMerge [{
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      shell = pkgs.zsh;
    } cfg.user.extraConfig];

    system.activationScripts.setAclForVonfry.text =
      let pathes = [
            {
              path = "${config.users.users.vonfry.home}/";
              mode = "u:sddm:x";
            }
            {
              path = "${config.users.users.vonfry.home}/.face.icon";
              mode = "u:sddm:r";
            }
          ];
      in lib.concatMapStringsSep "\n"
        (p: "${pkgs.acl}/bin/setfacl -m ${p.mode} ${p.path}" )
        pathes;

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

  };
}
