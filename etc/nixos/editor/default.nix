{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim neovim
    emacs
    editorconfig-core-c
  ];
  services.emacs.install = true;

  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ table-other ]; # table-other: wubi
  };
}
