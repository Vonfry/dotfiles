;;; treemacs packages -*- lexical-binding: t -*-

(use-package! treemacs
  :config
    (use-package treemacs-evil
      :demand t)
    (custom-set-variables
      '(treemacs-follow-after-init          nil)
      '(treemacs-width                      35)
      '(treemacs-indentation                4)
      '(treemacs-collapse-dirs              3)
      '(treemacs-silent-refresh             nil)
      '(treemacs-change-root-without-asking nil)
      '(treemacs-sorting                    'alphabetic-desc)
      '(treemacs-show-hidden-files          t)
      '(treemacs-never-persist              nil)
      '(treemacs-is-never-other-window      nil)
      '(treemacs-goto-tag-strategy          'refetch-index))
    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python"))))
    (`(t . t)
     (treemacs-git-mode 'extended))
    (`(t . _)
     (treemacs-git-mode 'simple))))


(use-package! treemacs-projectile
  :after projectile
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-treenode 'treemacs-projectile-toggle))
