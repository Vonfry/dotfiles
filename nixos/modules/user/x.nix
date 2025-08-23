{ config, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.x.enable {
    services.xserver.desktopManager.wallpaper.mode = "center";
    # NixOS per-user profile also uses this.
    environment.pathsToLink = [ "/share/fcitx5" ];
  };
}
