;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :custom
  (elfeed-db-directory (expand-file-name "elfeed/db" vonfry-local-dir))
  (elfeed-enclosure-directory (expand-file-name "elfeed/enclosure" vonfry-local-dir))
  :hook
  (evil-mode . (lambda ()
   (evil-set-initial-state 'elfeed-search-mode 'emacs)
   (evil-set-initial-state 'elfeed-show-mode   'emacs)))
  :config
  (load +feed-local-file t t)
  :general
  ("C-x w" 'elfeed)
  (nmap-at
    "f" 'elfeed))
