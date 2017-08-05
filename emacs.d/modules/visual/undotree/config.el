;;; undo tree config -*- lexical-binding: t; -*-

(vonfry-use-package! 'undotree
  :init
  (defcustom +undotree-evil-nmap-prefix vonfry-keybind-evil-leader :group 'vonfry-module)
  (defcustom +undotree-history-directory (concat "undotree/" vonfry-local-dir) :group 'vonfry-module)
  :config
  (global-undo-tree-mode)
  (custom-set-variables
    '(undo-tree-auto-save-history t)
    '(undo-tree-history-directory-alist `((".*" ,+undotree-history-directory))`))
  (with-eval-after-load 'diminish
    (diminish 'undo-tree-mode))
  :general
  (nmap :prefix +undotree-evil-nmap-prefix
        "u" 'undo-tree-visualize)
  )
