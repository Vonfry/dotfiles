;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :custom
  (elfeed-db-directory (expand-file-name "elfeed/db" vonfry-local-dir))
  (elfeed-enclosure-directory (expand-file-name "elfeed/enclosure" vonfry-local-dir))
  :hook
  ((evil-mode . (lambda ()
    (evil-set-initial-state 'elfeed-search-mode 'emacs)
    (evil-set-initial-state 'elfeed-show-mode   'emacs)))
   ((elfeed-show elfeed-search) . vonfry/toggle-trailing-whitespace))
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))
