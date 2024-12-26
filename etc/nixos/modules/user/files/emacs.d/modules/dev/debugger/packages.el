;;; debugger/packages.el --- -*- lexical-binding: t -*-
;;

(use-package dape
  :custom
  (dape-adapter-dir (expand-file-name "debug-adapters" vonfry-local-dir))
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "' d" dape-global-map
    "\""  dape-global-map))

(use-package compile
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "' c" 'compile
    "' C" 'recompile))
