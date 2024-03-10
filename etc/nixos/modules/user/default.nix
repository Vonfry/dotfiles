{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
  vonfryFace = with pkgs; runCommandNoCC "" {} ''
    mkdir -p $out/share/sddm/faces/
    ln -s ${vonfryPackages.iconFace} $out/share/sddm/faces/vonfry.face.icon
  '';
  userconfig = {
    users.motd = builtins.readFile ./files/motd;

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

        vonfry = {
          inherit (cfg) enable workspace;
        };
      };
    };
  };

  xconfig = {
    services.xserver.desktopManager.wallpaper.mode = "center";
    environment.systemPackages = [ cfg.facePackage ];
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

  options.vonfry.facePackage = mkOption {
    default = vonfryFace;
    description =
      "A face picture for sddm under sddm/faces named <user>.face.icon.";
    type = types.package;
  };

  config = mkMerge [
    (mkIf cfg.enable userconfig)
    (mkIf cfg.x.enable xconfig)
  ];
}
