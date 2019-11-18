;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :straight nil
  :general
  (+nmap-leader-def
    "; i" 'imenu))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (+nmap-imenu-def
    "t" 'imenu-list-smart-toggle))
