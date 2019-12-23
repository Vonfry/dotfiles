;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :straight nil
  :general
  (+mmap-leader-def
    "i"   'imenu
    "; i" 'imenu))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (+mmap-imenu-def
    "t" 'imenu-list-smart-toggle))
