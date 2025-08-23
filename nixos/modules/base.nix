{
  config,
  pkgs,
  lib,
  ...
}:

with lib;
let
  cfg = config.vonfry;
  hmCfg = config.home-manager.users.vonfry;
in
{
  config = mkIf cfg.enable {
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

      lsof

      file
      patch
      parallel
      ripgrep
      fd
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
        substituters = mkBefore [ "https://nix-community.cachix.org" ];
        keep-outputs = true;
        keep-derivations = true;
      };

      # These don't read from hm ones because hm module can be disable.
      gc = {
        automatic = mkDefault (!config.programs.nh.clean.enable);
        options = hmCfg.nix.gc.automatic;
        dates = hmCfg.nix.gc.dates;
      };
    };

    nixpkgs.config = import ./home/files/nixpkgs.nix;

    boot = {
      tmp.useTmpfs = mkDefault true;
      initrd.systemd.enable = true;
    };
    system = {
      etc.overlay = {
        enable = false;
        mutable = false;
      };
    };

    services = {
      # TODO switch to sysusers if it supports normal user.
      userborn.enable = true;
      dbus.enable = true;
      openssh = {
        enable = mkDefault false;
        allowSFTP = mkDefault true;
        hostKeys = [
          {
            bits = 4096;
            path = "${config.vonfry.preservation.dir}/etc/ssh/ssh_host_rsa_key";
            type = "rsa";
          }
          {
            path = "${config.vonfry.preservation.dir}/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
        ];
        settings = {
          PermitRootLogin = mkDefault "no";
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

    # These don't read from hm ones because hm module can be disable.
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = hmCfg.programs.nh.clean.dates;
        extraArgs = hmCfg.programs.nh.clean.extraArgs;
      };
      flake = mkDefault hmCfg.programs.nh.flake;
    };

    # FIXME open this if nh implement all features.
    # system.tools.nixos-rebuild.enable = mkDefault (!programs.nh.enable);

    system.stateVersion = mkDefault "25.05";
  };
}
