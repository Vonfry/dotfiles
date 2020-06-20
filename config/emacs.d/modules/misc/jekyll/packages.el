;;; jekyll packages -*- lexical-binding: t -*-
;;

(package! easy-jekyll
  :general
  (+mmap-at-def "b" 'easy-jekyll)
  :hook
  (evil-mode . (lambda ()
   (evil-set-initial-state 'easy-jekyll-mode 'emacs)))
  :config
  (when +jekyll-root
    (dolist (dir '(+jekyll-html-dir))
      (unless (file-exists-p dir)
        (make-directory dir)))))
