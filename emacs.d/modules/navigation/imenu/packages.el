;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu-anywhere
  :config
  :general
  (nmap :prefix +nmap-leader
        +nmap-code 'ivy-imenu-anywhere))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (nmap :prefix +nmap-leader
        +nmap-tag 'imenu-list-smart-toggle))
