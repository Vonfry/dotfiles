;;; packages config -*- lexical-binding: t -*-
;;

(package! password-store
  :general
  (+mmap-at-def
    "p"   'password-store-copy
    "P c" 'password-store-clear
    "P s" 'password-store-init
    "P i" 'password-store-insert
    "P g" 'password-store-generate
    "P d" 'password-store-remove
    "P r" 'password-store-rename
    "P u" 'password-store-url
    "P v" 'password-store-version))
