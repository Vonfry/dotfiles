;;; google-translate config -*- lexical-binding: t -*-

(use-package! google-translate
  :config
  (require 'google-translate-smooth-ui)
  (global-set-key "\C-ct" 'google-translate-at-point)
  (global-set-key "\C-cT" 'google-translate-query-translate))

