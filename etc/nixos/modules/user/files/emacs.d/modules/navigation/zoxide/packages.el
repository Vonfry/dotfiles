;;; zoxide packages -*- lexical-binding: t -*-
;;

(use-package zoxide
  :general
  (nmap "gc" '+zoxide-fzf
        "gC" 'zoxide-travel))
