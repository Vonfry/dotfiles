{ config, pkgs, lib, ... }:

let
  localFiles = [ ./base.local.nix ];
in
{
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "dvorak-programmer";

  time.timeZone = "Asia/Shanghai";

  environment.systemPackages = with pkgs; [
    # sudo
    gnutls cacert
    pciutils usbutils inxi
    exfat

    lnav
    atop htop
    lm_sensors lsof

    file patch colordiff parallel
    zip unzip
    ripgrep fd exa bat
  ];

  security.sudo.enable = true;

  nix = {
    optimise.automatic = true;
    trustedUsers = [ "root" "@wheel" ];
    maxJobs = "auto";
    buildCores = 0;
  };


  nixpkgs = {
    config = import ./user/vonfry/files/nixpkgs.nix;
    overlays = import ./user/vonfry/overlay/overlays.nix;
  };

  services = {
    syslog-ng.enable = true;
    logrotate.enable = true;
  };

  system.stateVersion = "20.03";

  imports = localFiles;
}
