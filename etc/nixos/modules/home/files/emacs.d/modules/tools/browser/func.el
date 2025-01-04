;;; browser/func.el --- -*- lexical-binding: t -*-
;;

(defun +browse/switch-emacs ()
  (interactive)
  (setq browse-url-browser-function 'eww))

(defun +browse/switch-generic ()
  (interactive)
  (setq browse-url-browser-function 'browse-url-generic))
