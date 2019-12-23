;;; w3m func -*- lexical-binding: t -*-
;;

(defun +browse/switch-emacs ()
  (browse-url-browser-function #'w3m-browse-url))

(defun +browse/switch-generic ()
  (browse-url-browser-function #'browse-url-default-browser))
