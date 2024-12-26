;;; debugger/packages.el --- -*- lexical-binding: t -*-
;;

(use-package dape
  :custom
  (dape-adapter-dir (expand-file-name "debug-adapters" vonfry-local-dir))
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "' d" dape-global-map
    "\""  dape-global-map))
