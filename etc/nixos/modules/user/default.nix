{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
  vonfryFace = with pkgs; runCommandNoCC "" {} ''
    mkdir -p $out/share/sddm/faces/
    ln -s ${vonfryPackages.icon-face} $out/share/sddm/faces/vonfry.face.icon
  '';
in {
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
      type = types.functionTo types.attrs;
    };
  };

  config = mkIf cfg.enable {
    users.motd = builtins.readFile ./files/motd;

    environment.systemPackages = [ vonfryFace ];

    services.xserver.desktopManager.wallpaper.mode = "center";

    users.users.vonfry = mkMerge [{
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      shell = pkgs.zsh;
    } cfg.user.extraConfig];

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
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
