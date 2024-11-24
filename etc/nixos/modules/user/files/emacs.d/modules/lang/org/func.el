;;; org/func.el --- -*- lexical-binding: t -*-
;;

(defun +org--find (path)
  (consult-find path))

(defun +org/find-agenda ()
  (interactive)
  (+org--find +org-agenda-dir))

(defun +org/find-notes ()
  (interactive)
  (+org--find +org-note-dir))

(defun +org/find-contacts ()
  (interactive)
  (+org--find +org-contacts-dir))

(defun +org/open-capture ()
  (interactive)
  (find-file +org-capture-file))

(defun +org/ql-notes (query)
  (interactive "Squery: ")
  (org-ql-search
    (org-ql-search-directories-files
     :directories (list +org-note-dir)
     :recurse t)
    query
    :title "Query Notes"))
