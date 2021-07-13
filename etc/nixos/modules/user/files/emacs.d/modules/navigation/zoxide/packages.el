;;; zoxide packages -*- lexical-binding: t -*-
;;

(use-package zoxide
  :custom
  (zoxide-find-file-function #'counsel-fzf)
  :general
  (nmap
    "gz" 'zoxide-find-file
    "gZ" 'zoxide-find-file))
