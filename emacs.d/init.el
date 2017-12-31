;;; init.el -*- lexical-binding: t; -*-
;;
;; This file is only usod to load core file.

;; If you want to custom variables in vonfry, you should add `custom-set-variables` before (require 'core)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(require 'core)

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
