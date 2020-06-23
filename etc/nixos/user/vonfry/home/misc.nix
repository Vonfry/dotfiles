{ pkgs, ... }:

let
  confLinux = {
    fonts.fontconfig.enable = true;
    home.file = {
      ".config/fctix/rime/default.custom.yaml" = {
        source = ./files/rime/default.custom.yaml;
        onChange = ''
          rm ~/.config/fcitx/rime/default.yaml
          fcitx-remote -r
        '';
      };
      ".config/fctix/rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
    };
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 14400;
      enableSshSupport = true;
      extraConfig = ''
        allow-emacs-pinentry
        allow-preset-passphrase
      '';
    };
  };
  confDarwin = {
    home.file = {
      "Library/Rime/default.custom.yaml".source = ./files/rime/default.custom.yaml;
      "Library/Rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
      "Library/Rime/squirrel.custom.yaml".source = ./files/rime/squirrel.custom.yaml;
      ".gnupg/gpg-agent.conf".text = ''
        default-cache-ttl 14400
        allow-emacs-pinentry
        enable-ssh-support
        allow-preset-passphrase
      '';
    };
  };
  conf = {
  };
in conf // (if pkgs.stdenv.isDarwin then confDarwin else confLinux)
