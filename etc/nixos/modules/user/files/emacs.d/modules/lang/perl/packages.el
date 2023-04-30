;;; perl packages -*- lexical-binding: t -*-
;;

(use-package cperl-mode
  :ensure nil
  :general
  (nmap-mode :keymaps 'cperl-mode-map
    "l" 'cperl-lineup
    "d" 'cperl-perldoc
    "?" 'cperl-perldoc-at-point
    "=" 'cperl-indent-line)
  :init
  (defalias 'perl-mode 'cperl-mode))
