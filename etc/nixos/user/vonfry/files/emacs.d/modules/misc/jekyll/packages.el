;;; jekyll packages -*- lexical-binding: t -*-
;;

(package! easy-jekyll
  :general
  (+mmap-at-def "b" 'easy-jekyll)
  :hook
  (evil-mode . (lambda ()
   (evil-set-initial-state 'easy-jekyll-mode 'emacs)))
  :config
  (when (and +jekyll-dir
             (not (file-exists-p +jekyll-dir)))
    (make-directory dir)))
