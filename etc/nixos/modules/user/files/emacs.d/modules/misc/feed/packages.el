;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :custom
  (elfeed-db-directory (expand-file-name "elfeed/db" vonfry-local-dir))
  (elfeed-enclosure-directory (expand-file-name "elfeed/enclosure" vonfry-local-dir))
  :config
  (load +feed-local-file t t)
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))
