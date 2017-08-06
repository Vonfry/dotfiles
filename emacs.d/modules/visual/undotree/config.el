;;; undo tree config -*- lexical-binding: t; -*-

(vonfry|use-package! undotree
  :init
  (defcustom +undotree-nmap-prefix
    vonfry-keybind-evil-leader
    "undotree evil prefix key"
    :group 'vonfry-module)
  (defcustom +undotree-history-directory
    (concat "undotree/" vonfry-local-dir)
    "undotree history directory"
    :group 'vonfry-module)
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  (custom-set-variables
    '(undo-tree-auto-save-history t)
    '(undo-tree-history-directory-alist `((".*" ,+undotree-history-directory))`))
  :general
  (nmap :prefix +undotree-nmap-prefix
        vonfry-keybind-evil-undotree 'undo-tree-visualize))
