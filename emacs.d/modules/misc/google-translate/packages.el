;;; google-translate package -*- lexical-binding: t -*-
;;

(package! google-translate
  :config
  (require 'google-translate-smooth-ui)
  :general
  ("C-c t" 'google-translate-at-point)
  ("C-c T" 'google-translate-query-translate))

