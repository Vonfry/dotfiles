;;; undo tree modules -*- lexical-binding: t; -*-
;;

(package! undo-tree
  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-history-directory-alist `((".*" . ,(expand-file-name "undotree/" vonfry-cache-dir))))
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  :general
  (+mmap-leader-def
    "u" 'undo-tree-visualize))
