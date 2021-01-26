;;; diff packages -*- lexical-binding: t -*-
;;

(use-package diff-hl
  :hook
  ((text-mode prog-mode) . diff-hl-flydiff-mode))

(use-package ediff
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  :general
  (nmap-leader
    "e d" 'ediff))
