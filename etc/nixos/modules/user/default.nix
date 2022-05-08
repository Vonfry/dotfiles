{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
  vonfryFace = with pkgs; runCommandNoCC "" {} ''
    mkdir -p $out/share/sddm/faces/
    ln -s ${vonfryPackages.icon-face} $out/share/sddm/faces/vonfry.face.icon
  '';
in {

  imports = [
    (mkAliasOptionModule
      [ "vonfry" "homeConfiguration" ]
      [ "home-manager" "users" "vonfry" ])
    (mkAliasOptionModule
      [ "vonfry" "userConfiguration" ]
      [ "users" "users" "vonfry" ])
  ];

  config = mkIf cfg.enable {
    users.motd = builtins.readFile ./files/motd;

    environment.systemPackages = [ vonfryFace ];

    services.xserver.desktopManager.wallpaper.mode = "center";

    users.users.vonfry = {
      isNormalUser = true;
      home = "/home/vonfry";
      description = "Vonfry";
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      shell = pkgs.zsh;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.vonfry = _: {
        imports = [ ./home.nix ];

        vonfry = mkDefault {
          inherit (cfg) enable;
        };
      };
    };
  };
}
