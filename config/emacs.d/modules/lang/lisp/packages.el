;;; lisp packages -*- lexical-binding: t -*-
;;

(package! eldoc
  :ensure nil
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(load (expand-file-name "./emacs_lisp.el"
                        (file-name-directory load-file-name)) t t)
