;;; nix/config.el --- -*- lexical-binding: t -*-
;;

(use-package nix-ts-mode
  :mode "\\.nix\\'"
  :hook (nix-ts-mode . eglot-ensure))
