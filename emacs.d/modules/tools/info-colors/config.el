;;; info-colors config -*- lexical-binding: t; -*-

(use-package! info-colors
  :hook
  (Info-selection . info-colors-fontify-node))
