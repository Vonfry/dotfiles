;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file +treemacs-persist-file)
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
  :general
  (+mmap-leader-def
    "P t" 'treemacs-projectile))

(package! treemacs-magit
  :after treemacs magit)
