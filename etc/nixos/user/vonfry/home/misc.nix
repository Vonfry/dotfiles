{ pkgs, ... }:

let isDarwin = pkgs.stdenv.isDarwin;
in {
  fonts.fontconfig.enable = !isDarwin;
  home.file = 
    if !isDarwin then {
      ".config/fctix/rime/default.custom.yaml" = {
        source = ./files/rime/default.custom.yaml;
        onChange = ''
          rm ~/.config/fcitx/rime/default.yaml
          fcitx-remote -r
        '';
      };
      ".config/fctix/rime/installation.custom.yaml".source = ./files/rime/installation.custom.yaml;
    } else {
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
  services.gpg-agent = {
    enable = pkgs.stdenv.isLinux;
    defaultCacheTtl = 14400;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-preset-passphrase
    '';
  };
}
