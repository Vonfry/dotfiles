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
    boot.tmp.useTmpfs = mkDefault true;

    i18n.defaultLocale = "en_US.UTF-8";
    console.keyMap = mkDefault "dvorak-programmer";

    time.timeZone = mkDefault "Asia/Shanghai";

    environment.systemPackages = with pkgs; [
      gnutls
      cacert
      pciutils
      usbutils
      inxi
      exfat
      zstd

      lnav
      btop
      lsof

      file
      patch
      colordiff
      parallel
      ripgrep
      fd
      lsd
    ];

    nix = {
      optimise.automatic = true;
      settings = {
        trusted-users = [
          "root"
          "@wheel"
        ];
        cores = 0;
        max-jobs = mkDefault "auto";
        auto-optimise-store = true;
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        substituters = lib.mkBefore [ "https://nix-community.cachix.org" ];
      };
      gc = {
        automatic = mkDefault true;
        options = "--delete-older-than 14d";
        dates = "Sun 19:00";
      };
      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
      '';

    };

    nixpkgs.config = import ./user/files/nixpkgs.nix;

    services = {
      dbus.enable = true;
      openssh = {
        enable = mkDefault false;
        allowSFTP = mkDefault true;
        settings = {
          PermitRootLogin = mkDefault "prohibit-password";
          PasswordAuthentication = mkDefault false;
          ClientAliveInterval = 60;
          ClientAliveCountMax = 4;
        };
      };
      udisks2.enable = true;
    };

    documentation = {
      man.generateCaches = true;
    };

    security = {
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = mkDefault true;
        execWheelOnly = true;
      };
      pam = {
        sshAgentAuth = {
          enable = mkDefault true;
          authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
        };
      };
    };

    system.stateVersion = "24.11";
  };
}
