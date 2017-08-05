;;; init.el -*- lexical-binding: t; -*-
;;
;; This file is only usod to load core file.

;; If you want to custom variables in vonfry, you should add `custom-set-variables` before (require 'core)
(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(require 'core)

(when (file-exists-p vonfry-custom-file)
  (load custom-file))

(provite 'init)
