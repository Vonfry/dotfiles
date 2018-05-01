;;; google-translate config -*- lexical-binding: t -*-

(use-package! google-translate
  :config
  (require 'google-translate-smooth-ui)
  :general
  ("\C-ct" 'google-translate-at-point)
  ("\C-cT" 'google-translate-query-translate))

