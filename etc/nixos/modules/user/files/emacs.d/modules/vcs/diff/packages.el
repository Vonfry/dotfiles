;;; diff/packages.el --- -*- lexical-binding: t -*-
;;

(use-package diff-hl
  :hook
  ((prog-mode text-mode) . diff-hl-mode)
  :custom
  (diff-hl-flydiff-mode 1))

(use-package ediff
  :custom
  (ediff-window-setup-function 'ediff-setup-windows-plain)
  :general
  (nmap-leader
    "e d" 'ediff))
