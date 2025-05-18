;;; services/packages.el --- -*- lexical-binding: t; -*-
;;

(use-package daemons
  :general
  (nmap-leader "s s" 'daemons))

(use-package journalctl-mode
  :general
  (nmap-leader
    "s t" 'journalctl))
