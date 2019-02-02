{ config, pkgs, ...}:

{
  fonts.fonts = with pkgs; [ hack-font ];
}
