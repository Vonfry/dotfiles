{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zip unzip
  ];

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.pulseaudio.enable = true;
}
