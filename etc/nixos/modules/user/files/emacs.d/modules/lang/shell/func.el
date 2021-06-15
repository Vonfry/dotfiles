;;; shell func -*- lexical-binding: t -*-
;;

(defun +shell/open-file-manager-x ()
  "Open file manager in system. This function is worked with `org-open-file'."
  (interactive)
  (org-open-file "." 'system))
