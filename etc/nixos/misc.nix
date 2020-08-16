{ config, pkgs, ...}:

{
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ rime ]; # wubi
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  fonts = {
    fonts = with pkgs; [
      hack-font
      sarasa-gothic
      symbola
      liberation_ttf
      source-han-sans-simplified-chinese
      source-han-serif-simplified-chinese
    ];
    fontconfig = {
      enable = true;
      # config this by your self, it is depended on which screen you
      # are using. It is suggested as a multiple of 6 or 12.
      # dpi = 96;
      defaultFonts = {
        monospace = [ "Hack" "Sarasa Mono SC" ];
        sansSerif = [ "Liberation Sans" "Soruce Han Sans SC" ];
        serif = [ "Liberation Serif" "Source Han Serif SC" "Symbola" ];
      };
    };
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      load-module module-dbus-protocol
      load-module module-equalizer-sink
    '';
  };

  environment.systemPackages = with pkgs; [ pavucontrol qpaeq ];
}
