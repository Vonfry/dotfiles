;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-persist-file (expand-file-name "treemacs-persist" vonfry-cache-dir))
  :general
  (nmap :prefix +nmap-leader
        +nmap-treenode 'treemacs))

(package! treemacs-evil
  :after treemacs evil)

(package! treemacs-projectile
  :after treemacs projectile
  :general
  (nmap :prefix +nmap-project-prefix
        "t" 'treemacs-projectile))

(package! treemacs-magit
  :after treemacs magit)
