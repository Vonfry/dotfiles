;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :custom
  (elfeed-db-directory +feed-db-directory)
  (elfeed-enclosure-directory +feed-enclosure-directory)
  :hook
  ((evil-mode . (lambda ()
    (evil-set-initial-state 'elfeed-search-mode 'emacs)
    (evil-set-initial-state 'elfeed-show-mode   'emacs)))
   ((elfeed-show elfeed-search) . (lambda () (custom-set-variables '(show-trailing-whitespace nil)))))
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))
