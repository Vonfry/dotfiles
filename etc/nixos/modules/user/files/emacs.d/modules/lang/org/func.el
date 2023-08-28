;;; org func -*- lexical-binding: t -*-
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

(defun +org/roam-switch (path)
  "A path is a roam."
  (interactive "Droam: ")
  (+org--roam-set-path path))

(defun +org/open-capture ()
  (interactive)
  (find-file +org-capture-file))


(defun +org/id-update-recursively (dir)
  (interactive "Ddir: ")
  (org-id-update-id-locations (directory-files-recursively dir "\\.org$")))

(defun +org/id-update-default ()
  (interactive)
  (+org/id-update-recursively org-roam-directory)
  (org-id-update-id-locations)
  (org-id-locations-save))

(defun +org/insert-zero-width-space ()
  (interactive)
  (insert-char ?\u200B)) ;; code for ZERO WIDTH SPACE
