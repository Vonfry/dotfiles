;;; undo/packages.el --- -*- lexical-binding: t -*-
;;

(use-package vundo
  :custom
  (vundo-window-side 'top)
  :general
  (nmap-leader "u" 'vundo))
