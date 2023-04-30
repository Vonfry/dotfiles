;;; dot pagkages -*- lexical-binding: t -*-
;;

(use-package graphviz-dot-mode
  :general
  (nmap-leader :keymaps 'graphviz-dot-mode-map
    "r" 'compile
    "=" 'graphviz-dot-indent-graph)
  (nmap-mode :keymaps 'graphviz-dot-mode-map
    "p" 'graphviz-dot-preview
    "v" 'graphviz-dot-view))
