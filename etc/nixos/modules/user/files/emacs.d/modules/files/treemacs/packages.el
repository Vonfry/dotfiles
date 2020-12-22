;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-tag-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-local-dir))
  :general
  (nmap-leader
    "d"   'treemacs
    "M m" 'treemacs-bookmark)
  (nmap-leader
    "P F" 'treemacs-find-file
    "P A" 'treemacs-add-and-display-current-project))

(package! treemacs-evil
  :after (treemacs evil))

(package! treemacs-projectile
  :after (treemacs projectile)
  :general
  (nmap-leader
    "P T" 'treemacs-projectile))

(package! treemacs-magit
  :after (treemacs magit))

(package! treemacs-icons-dired
  :config
  (treemacs-icons-dired-mode))
