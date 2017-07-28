;;; init.el -*- lexical-binding: t; -*-
;;
;; This file is only usod to load core file.

(add-to-list 'load-path (expand-file-name "core" user-emacs-directory))
(require 'core)

(when (file-exists-p vonfry-custom-file)
  (load custom-file))

(provite 'init)
