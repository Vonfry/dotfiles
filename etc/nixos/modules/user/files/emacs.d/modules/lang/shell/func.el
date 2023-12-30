;;; shell/func.el --- -*- lexical-binding: t -*-
;;

(defun +shell/display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
