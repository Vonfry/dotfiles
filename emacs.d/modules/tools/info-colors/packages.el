;;; info-colors modules -*- lexical-binding: t; -*-

(package! info-colors
  :hook
  (Info-selection . info-colors-fontify-node))
