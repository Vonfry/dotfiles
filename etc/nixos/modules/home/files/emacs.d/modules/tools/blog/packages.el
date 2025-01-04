;;; blog/packages.el --- -*- lexical-binding: t -*-
;;

(use-package easy-hugo
  :general
  (nmap-at "b" 'easy-hugo)
  :config
  (evil-set-initial-state 'easy-hugo-mode 'emacs))
