;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-tag-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-local-dir))
  :general
  (+mmap-leader-def
    "d"   'treemacs
    "M m" 'treemacs-bookmark)
  (+mmap-tree-def
    "d" 'treemacs-find-file
    "p" 'treemacs-add-and-display-current-project))

(package! treemacs-evil
  :after (treemacs evil))

(package! treemacs-projectile
  :after (treemacs projectile)
  :general
  (+mmap-leader-def
    "P t" 'treemacs-projectile))

(package! treemacs-magit
  :after (treemacs magit))

(package! treemacs-icons-dired
  :config
  (treemacs-icons-dired-mode))
