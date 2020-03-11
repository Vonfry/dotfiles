;;; imenu packages -*- lexical-binding: t -*-
;;

(package! imenu
  :ensure nil
  :general
  (+mmap-prog-def
    "i" 'imenu))

(package! imenu-list
  :custom
  (imenu-list-focus-after-activation t)
  (imenu-list-auto-resize t)
  :general
  (+mmap-prog-def
    "t" 'imenu-list-smart-toggle))
