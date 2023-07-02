{ config, lib, pkgs, ...}:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };
  };
}
