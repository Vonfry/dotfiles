;;; info-colors config -*- lexical-binding: t; -*-

(use-package! info-colors
  :config
  (add-hook 'Info-selection-hook 'info-colors-fontify-node))
