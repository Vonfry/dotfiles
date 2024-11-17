;;; org/func.el --- -*- lexical-binding: t -*-
;;

(defun +org--find (path)
  (consult-find path))

(defun +org/find-agenda ()
  (interactive)
  (+org--find +org-agenda-dir))

(defun +org/append-to-agenda-file ()
  (interactive)
  (let ((default-directory +org-agenda-dir))
    (call-interactively 'append-to-file)))

(defun +org/find-notes ()
  (interactive)
  (+org--find +org-note-dir))

(defun +org/find-contacts ()
  (interactive)
  (+org--find +org-contacts-dir))

(defun +org/notes-switch (path)
  "A path is a roam."
  (interactive "Dnotes: ")
  (+org--roam-set-path path))

(defun +org/open-capture ()
  (interactive)
  (find-file +org-capture-file))
