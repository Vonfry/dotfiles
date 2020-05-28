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
