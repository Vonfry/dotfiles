;;; proced/packages.el --- -*- lexical-binding: t -*-
;;

(use-package proced
  :ensure nil
  :custom
  (proced-format 'long)
  :general
  (nmap-leader
    "s l" 'proced))
