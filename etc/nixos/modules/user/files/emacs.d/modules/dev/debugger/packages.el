;;; debugger/packages.el --- -*- lexical-binding: t -*-
;;

(use-package realgud
  :general
  (nmap-leader :keymaps 'prog-mode-map
    "' d" 'realgud:shortkey-mode-map))

