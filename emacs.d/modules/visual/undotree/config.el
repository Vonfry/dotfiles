;;; undo tree config -*- lexical-binding: t; -*-

(vonfry|use-package! undotree
  :init
  (defcustom +undotree-nmap-prefix
    vonfry-keybind-evil-leader
    "undotree evil prefix key"
    :type 'string
    :group 'vonfry-modules)
  (defcustom +undotree-history-directory
    (expand-file-name "undotree/" vonfry-local-dir)
    "undotree history directory"
    :type 'string
    :group 'vonfry-modules)
  (unless (file-exists-p +undotree-history-directory)
    (make-directory +undotree-history-directory))
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  (custom-set-variables
    '(undo-tree-auto-save-history t)
    '(undo-tree-history-directory-alist `((".*" ,+undotree-history-directory))))
  :general
  (nmap :prefix +undotree-nmap-prefix
        vonfry-keybind-evil-undotree 'undo-tree-visualize))
