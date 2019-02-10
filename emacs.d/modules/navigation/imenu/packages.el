;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :ensure nil
  :general
  (nmap :prefix +nmap-leader
    +nmap-code 'imenu))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (nmap :prefix +nmap-leader
    +nmap-tag 'imenu-list-smart-toggle))
