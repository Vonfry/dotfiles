;;; uniline/packages.el --- -*- lexical-binding: t -*-
;;

(use-package uniline
  :config
  (evil-set-initial-state 'uniline-mode 'emacs)
  :general
  (nmap-at
    "e n" 'uniline-mode))
