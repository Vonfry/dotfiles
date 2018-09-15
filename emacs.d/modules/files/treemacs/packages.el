;;; treemacs packages -*- lexical-binding: t -*-
;;

(package! treemacs
  :custom
  (treemacs-follow-after-init          nil)
  (treemacs-width                      35)
  (treemacs-indentation                4)
  (treemacs-collapse-dirs             (if (executable-find "python") 3 0))
  (treemacs-silent-refresh             nil)
  (treemacs-change-root-without-asking nil)
  (treemacs-sorting                    'alphabetic-desc)
  (treemacs-show-hidden-files          t)
  (treemacs-never-persist              nil)
  (treemacs-is-never-other-window      nil)
  (treemacs-goto-tag-strategy          'refetch-index)
  (treemacs-persist-file               +treemacs-persist-file)
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (pcase (cons (not (null (executable-find "git")))
               (not (null (executable-find "python"))))
  (`(t . t)
   (treemacs-git-mode 'extended))
  (`(t . _)
   (treemacs-git-mode 'simple)))
  :general
  (nmap :prefix +nmap-leader
        +nmap-treenode 'treemacs))

(package! treemacs-evil
  :after treemacs evil)

(package! treemacs-projectile
  :after projectile treemacs)
