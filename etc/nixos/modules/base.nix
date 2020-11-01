{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.vonfry;
in {
  config = mkIf cfg.enable {
    boot.tmpOnTmpfs = mkDefault true;

    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = mkDefault "dvorak-programmer";

    time.timeZone = mkDefault "Asia/Shanghai";

    environment.systemPackages = with pkgs; [
      # sudo
      gnutls cacert
      pciutils usbutils inxi
      exfat

      lnav
      atop htop
      lm_sensors lsof

      zip unzip
      file patch colordiff parallel
      ripgrep fd exa bat
    ];

    nix = {
      optimise.automatic = true;
      trustedUsers = [ "root" "@wheel" ];
      buildCores = 0;
      maxJobs = mkDefault "auto";
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 14d";
        dates = "Sun 19:00";
      };
    };

    nixpkgs = {
      config = import ./user/files/nixpkgs.nix;
      overlays = import ./overlay/overlays.nix;
    };

    services = {
      dbus.enable = true;
      openssh =  {
        enable = mkDefault false;
        allowSFTP = mkDefault true;
        passwordAuthentication = mkDefault false;
        permitRootLogin = mkDefault "prohibit-password";
        extraConfig = ''
          ClientAliveInterval 60
          ClientAliveCountMax 4
        '';
      };
    };

    security = {
      sudo = {
        enable = true;
        extraConfig = mkDefault ''
          Defaults timestamp_timeout=30
          Defaults env_keep += "*_proxy *_PROXY"
        '';
        wheelNeedsPassword = mkDefault true;
      };
      pam.enableSSHAgentAuth = mkDefault true;
    };

    system.stateVersion = "20.09";
  };
}
