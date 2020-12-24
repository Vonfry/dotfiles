;;; packages config -*- lexical-binding: t -*-
;;

(use-package password-store
  :custom
  (password-store-password-length 32)
  :general
  (nmap-at
    "p"   'password-store-copy
    "P"   '(:ignore t :which-key "pass")
    "P c" 'password-store-clear
    "P s" 'password-store-init
    "P i" 'password-store-insert
    "P e" 'password-store-edit
    "P g" 'password-store-generate
    "P d" 'password-store-remove
    "P r" 'password-store-rename
    "P u" 'password-store-url
    "P v" 'password-store-version))
