;;; direnv packages -*- lexical-binding: t -*-
;;

(use-package direnv
  :custom
  (direnv-non-file-modes
    '(ielm-mode
      eshell-mode
      geiser-mode
      slime-mode))
  :general
  (nmap-leader
   "' e" 'direnv-update-environment)
  :config
  (direnv-mode t))
