{ config, lib, pkgs, ...}:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
