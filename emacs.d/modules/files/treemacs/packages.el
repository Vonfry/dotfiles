;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-cache-dir))
  :general
  (+mmap-leader-def
    "d" 'treemacs))

(package! treemacs-evil
  :after treemacs evil)

(package! treemacs-projectile
  :general
  (+mmap-leader-def
    "P t" 'treemacs-projectile))

(package! treemacs-magit
  :after treemacs magit)
