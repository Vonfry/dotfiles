;;; zoxide packages -*- lexical-binding: t -*-
;;

(use-package zoxide
  :custom
  (zoxide-find-file-function #'counsel-fzf)
  :general
  (nmap
    "gc" 'zoxide-find-file
    "gC" 'zoxide-travel)
  (:keymaps 'ranger-normal-mode-map
    "zc" 'zoxide-travel))
