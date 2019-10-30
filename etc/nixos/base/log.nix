{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ lnav ];
  services = {
    syslog-ng.enable = true;
    logrotate.enable = true;
  };
}
