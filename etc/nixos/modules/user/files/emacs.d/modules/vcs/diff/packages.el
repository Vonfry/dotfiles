;;; diff packages -*- lexical-binding: t -*-
;;

(use-package diff-hl
  :custom
  (diff-hl-flydiff-mode 1))

(use-package ediff
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  :general
  (nmap-leader
    "e d" 'ediff))
