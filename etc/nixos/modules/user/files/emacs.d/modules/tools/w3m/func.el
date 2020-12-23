;;; w3m func -*- lexical-binding: t -*-
;;

(defun +browse/switch-emacs ()
  (interactive)
  (setq browse-url-browser-function 'w3m-browse-url))

(defun +browse/switch-generic ()
  (interactive)
  (setq browse-url-browser-function 'browse-url-generic))
