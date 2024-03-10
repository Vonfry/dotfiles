{ config, lib, pkgs, ...}:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    sound.enable = mkDefault (!cfg.workspace.server);
    services.pipewire = {
      enable = mkDefault (!cfg.workspace.server);
      alsa.enable = true;
      wireplumber.enable = true;
    };
  };
}
