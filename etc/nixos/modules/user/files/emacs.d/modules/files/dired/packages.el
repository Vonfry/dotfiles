;;; dired packages -*- lexical-binding: t -*-
;;

(use-package dired-sidebar
  :general
  (nmap-leader
    "d" 'dired-sidebar-toggle-sidebar))
