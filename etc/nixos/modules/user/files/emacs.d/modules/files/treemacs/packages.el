;;; treemacs packages -*- lexical-binding: t -*-
;;

(use-package treemacs
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

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :general
  (nmap-leader
    "P T" 'treemacs-projectile))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package treemacs-icons-dired
  :config
  (treemacs-icons-dired-mode))
