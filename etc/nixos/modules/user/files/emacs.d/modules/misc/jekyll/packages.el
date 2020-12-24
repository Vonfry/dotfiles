;;; jekyll packages -*- lexical-binding: t -*-
;;

(use-package easy-jekyll
  :general
  (nmap-at "b" 'easy-jekyll)
  :hook
  (evil-mode . (lambda ()
   (evil-set-initial-state 'easy-jekyll-mode 'emacs))))
