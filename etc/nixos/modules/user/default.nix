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
    users.motd = builtins.readFile ./motd;

    users.users.vonfry = {
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "docker" "vboxusers" "networkmanager" ]
                    ++ optionals (hasAttr "extraGroups" cfg.extraConfig)
                                 cfg.extraConfig.extraGroups;
      shell = pkgs.zsh;
    } // removeAttrs [ "extraGroups" ] cfg.extraConfig;

    home-manager = {
      users.vonfry = args: (import ./home.nix args) // {
        vonfry.enable = cfg.enable;
      } // (cfg.hmConfig args);

      useUserPackages = true;
    };
  };
}
