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
      ranger
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
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
      '';

      binaryCachePublicKeys = lib.mkBefore [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      binaryCaches = lib.mkBefore [ "https://nix-community.cachix.org" ];
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
      pam = rec {
       enableSSHAgentAuth = mkDefault true;
       services.sudo.sshAgentAuth = mkDefault enableSSHAgentAuth;
      };
    };

    system.stateVersion = "20.09";
  };
}
