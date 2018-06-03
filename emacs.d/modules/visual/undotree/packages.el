;;; undo tree modules -*- lexical-binding: t; -*-
;;

(package! undo-tree
  :init
  (unless (file-exists-p +undotree-history-directory)
    (make-directory +undotree-history-directory))
  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist `((".*" . ,+undotree-history-directory)))
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  :general
  (nmap :prefix +undotree-nmap-prefix
    vonfry-keybind-evil-undotree 'undo-tree-visualize))
