{ config, pkgs, ...}:

{
  fonts.fonts = with pkgs; [ hack-font source-han-sans-simplified-chinese ];
}
