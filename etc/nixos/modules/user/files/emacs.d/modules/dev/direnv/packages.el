;;; direnv packages -*- lexical-binding: t -*-
;;

(use-package envrc
  :general
  (nmap-leader :infix "'" :keymaps 'envrc-mode-map
    "e" 'envrc-command-map)
  :hook (emacs-startup . envrc-global-mode))
