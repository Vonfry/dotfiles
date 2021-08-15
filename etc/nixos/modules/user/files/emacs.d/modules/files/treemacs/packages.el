;;; treemacs packages -*- lexical-binding: t -*-
;;

(use-package treemacs
  :custom
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-local-dir))
  :general
  (nmap-leader
    "d"   'treemacs
    "M m" 'treemacs-bookmark)
  (nmap-leader
    "P F" 'treemacs-find-file
    "P s" 'treemacs-switch-workspace
    "P e" 'treemacs-edit-workspaces
    "P A" 'treemacs-add-and-display-current-project)
  :config
  (treemacs-follow-mode 1)
  (treemacs-filewatch-mode 1))

(use-package treemacs-evil)

(use-package treemacs-projectile
  :after projectile
  :general
  (nmap-leader
    "P T" 'treemacs-projectile))

(use-package treemacs-magit
  :after magit
  :config
  (treemacs-git-mode 'deferred))

(use-package treemacs-icons-dired
  :config
  (treemacs-icons-dired-mode))
