;;; bib func -*- lexical-binding: t -*-
;;

(defvar +bib--set-counter most-negative-fixnum)

(defun +bib/switch-dir (path)
  "switch bib for notes and others"
  (interactive "Dbib search dir: ")
  (when (= +bib--set-counter most-negative-fixnum)
    (setq-default ebib-file-search-dirs nil))
  (setq +bib--set-counter (1- +bib--set-counter))
  (+bib--set-note-dir path)
  (setq-default
   ebib-reading-list-file (expand-file-name "reading.org" path)
   ebib-file-search-dirs (add-to-ordered-list
                          'ebib-file-search-dirs
                          path
                          +bib--set-counter)))

(defun +bib/switch-dir-from-search-dir ()
  "switch bib from search dir for notes and others"
  (interactive)
  (if (fboundp 'ivy-read)
     (ivy-read "bib serch dir: " ebib-file-search-dirs
               :require-match t
               :action '+bib/switch-dir)
     (message "not support")))

(defun +bib/switch-dir-current ()
  "switch bib for notes and others"
  (interactive)
  (+bib/switch-dir default-directory))

(defun +bib/switch-note-files ()
  "switch bib notes between single file or multiple files."
  (interactive)
  (+bib--set-note-dir default-directory)
  (setq-default +bib-note-is-single (not +bib-note-is-single)))

(defun +bib/toggle-insert-multiple ()
  (interactive)
  (setq-default
   ebib-citation-insert-multiple (not ebib-citation-insert-multiple)))

(defun +bib--set-note-dir (path)
  (if +bib-note-is-single
      (setq-default ebib-notes-file (expand-file-name "notes.org" path))
    (setq-default ebib-notes-directory path
                  ebib-notes-file nil)))
