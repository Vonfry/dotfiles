;;; bib func -*- lexical-binding: t -*-
;;

(fun! +bib/switch-dir (path)
  "switch bib for notes and others"
  (interactive "Dbib search dir: ")
  (eval `(custom-set! +bib-dir ,path)))

(fun! +bib/switch-dir-from-search-dir ()
  "switch bib from search dir for notes and others"
  (interactive)
  (if (fboundp 'ivy-read)
     (ivy-read "bib serch dir: " +bib-search-dir
               :require-match t
               :action (lambda (path) (eval `(custom-set! +bib-dir ,path))))
     (message "not support")))

(fun! +bib/switch-dir-current ()
  "switch bib for notes and others"
  (interactive)
  (+bib/switch-dir default-directory))

(fun! +bib/switch-note-files ()
  "switch bib notes between single file or multiple files."
  (interactive)
  (if +bib-note-is-single
    (custom-set! ebib-notes-directory ebib-notes-file)
    (custom-set! ebib-notes-file ebib-notes-directory))
  (custom-set! +bib-note-is-single (not +bib-note-is-single)))

(fun! +bib/switch-insert-single-or-multiple ()
  (interactive)
  (custom-set! ebib-citation-insert-multiple
               (not ebib-citation-insert-multiple)))
