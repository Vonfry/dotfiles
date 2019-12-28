;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-cache-dir))
  :general
  (+mmap-leader-def
    "d"   'treemacs
    "D"   '(nil :which-key "tree")
    "D d" 'treemacs-find-file
    "D p" 'treemacs-add-and-display-current-project
    "m"   'treemacs-bookmark))

(package! treemacs-evil
  :after treemacs evil)

(package! treemacs-projectile
  :after treemacs projectile
  :general
  (+mmap-leader-def
    "P t" 'treemacs-projectile))

(package! treemacs-magit
  :after treemacs magit)
