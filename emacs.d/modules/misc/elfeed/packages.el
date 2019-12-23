;;; elfeed packages -*- lexical-binding: t -*-
;;

(package! elfeed
  :general
  ("C-x w" 'elfeed)
  (+mmap-at-def
    "f" 'elfeed))

(package! elfeed-org
  :disabled
  :after elfeed org
  :custom (rmh-elfeed-org-files (list +elfeed-org-files))
  :config
  (elfeed-org))
