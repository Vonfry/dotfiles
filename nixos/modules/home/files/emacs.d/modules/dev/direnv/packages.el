;;; direnv/packages.el --- -*- lexical-binding: t -*-
;;

(use-package envrc
  :general
  (nmap-leader :keymaps 'envrc-mode-map
    "' e" 'envrc-command-map)
  :hook (emacs-startup . envrc-global-mode))
