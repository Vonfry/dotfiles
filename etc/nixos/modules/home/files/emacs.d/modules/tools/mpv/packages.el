;;; mpv/packages.el --- -*- lexical-binding: t -*-
;;

(use-package empv
  ; here are issues on its packages distribution in nixpkgs with hydra.
  ; disable it now until fixed.
  :disabled
  :general
  (nmap-at "v v" empv-map))
