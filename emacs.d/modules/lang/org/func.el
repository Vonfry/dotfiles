;;; org func -*- lexical-binding: t -*-
;;

(defun +org/find-agenda ()
  (interactive)
  (if (fboundp 'counsel-find-file)
    (counsel-find-file +org-agenda-dir)
    (let ((default-directory +org-agenda-dir))
      (call-interactively 'find-file))))

(defun +org/append-to-agenda-file ()
  (interactive)
  (let ((default-directory +org-agenda-dir))
    (call-interactively 'append-to-file)))
