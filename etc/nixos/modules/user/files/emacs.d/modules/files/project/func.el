;;; project func -*- lexical-binding: t -*-
;;

(defun +project/magit ()
  (interactive)
  (magit-status (project-root (project-current t))))
