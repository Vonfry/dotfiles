{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry;
in
{
  config = mkIf cfg.enable {
    systemd.generators = {
      # Disable xdg autostart and let user create autostart manually to avoid
      # unintended services.
      systemd-xdg-autostart-generator = "/dev/null";
    };
  };
}
