;;; org func -*- lexical-binding: t -*-
;;

(defun +org--find (path)
  (cond ((and (executable-find "fzf")
              (fboundp 'counsel-fzf))
         (counsel-fzf nil path))
        ((fboundp 'counsel-find-file)
         (counsel-find-file path))
        (t (let ((default-directory path))
             (call-interactively 'find-file)))))

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
  (+org--roam-set-path (path)))

(defun +org/open-capture ()
  (interactive)
  (find-file +org-capture-file))

(defun +org/id-update-default ()
  (interactive)
  (dolist (dir (list org-roam-directory))
    (org-id-update-id-locations (directory-files dir t "\\.org$")))
  (org-id-update-id-locations)
  (org-id-locations-save))
