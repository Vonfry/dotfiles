{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim neovim
    emacs
  ];
  services.emacs.install = true;

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ rime ]; # wubi
  };
}
