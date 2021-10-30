;;; shell func -*- lexical-binding: t -*-
;;

(defun +shell/open-file-manager-x ()
  "Open file manager in system. This function is worked with `org-open-file'."
  (interactive)
  (org-open-file "." 'system))

(defun +shell/display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(defun +shell/display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
