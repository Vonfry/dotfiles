;;; bib func -*- lexical-binding: t -*-
;;

(defvar +bib--set-counter most-negative-fixnum)

(defun +bib/switch-dir (path)
  "switch bib for notes and others"
  (interactive "Dbib search dir: ")
  (when (= +bib--set-counter most-negative-fixnum)
    (custom-set-variables '(ebib-file-search-dirs nil)))
  (setq +bib--set-counter (1- +bib--set-counter))
  (if +bib-note-is-single
      (setq-default
       ebib-notes-file (expand-file-name "notes.org" path))
    (setq-default ebib-notes-directory path
                  ebib-notes-file nil))
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
  (when +bib-note-is-single
      (setq-default
       ebib-notes-directory (file-name-directory ebib-notes-file)
       ebib-notes-file      nil))
  (custom-set-variables '(+bib-note-is-single (not +bib-note-is-single) t)))

(defun +bib/toggle-insert-multiple ()
  (interactive)
  (custom-set-variables
   '(ebib-citation-insert-multiple (not ebib-citation-insert-multiple) t)))
