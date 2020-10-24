{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  imports = [ <home-manager/nixos> ];

  options.vonfry = {
    user.extraConfig = {
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
      extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ];
      shell = pkgs.zsh;
    } cfg.extraConfig];

    home-manager = {
      users.vonfry = args: mkMerge [
        (import ./home.nix args)
        {
          vonfry = mkDefault {
            inherit (cfg) enable;
          };
        }
        (cfg.hmConfig args)
      ];

      useUserPackages = true;
    };
  };
}
