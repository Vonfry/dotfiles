;;; jekyll packages -*- lexical-binding: t -*-
;;

(use-package easy-jekyll
  :general
  (nmap-at "b" 'easy-jekyll)
  :config
  (evil-set-initial-state 'easy-jekyll-mode 'emacs))
