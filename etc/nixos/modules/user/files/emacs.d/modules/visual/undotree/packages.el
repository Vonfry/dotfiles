;;; undo tree modules -*- lexical-binding: t; -*-
;;

(use-package undo-tree
  :custom
  (undo-tree-auto-save-history t)
  (undo-tree-visualizer-timestamps t)
  (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist `(("." . ,(expand-file-name "undotree/" vonfry-cache-dir))))
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode)
  :general
  (nmap-leader
    "u" 'undo-tree-visualize))
