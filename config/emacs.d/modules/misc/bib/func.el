;;; bib func -*- lexical-binding: t -*-
;;

(fun! +bib/switch-dir (path)
  "switch bib for notes and others"
  (interactive "Dbib search dir: ")
  (custom-set! +bib-dir path))

(fun! +bib/switch-dir-from-search-dir ()
  "switch bib from search dir for notes and others"
  (if (fboundp 'ivy-read)
     (let ((path (ivy-read "bib serch dir: " +bib-search-dir
                           :require-match t)))
       (custom-set! +bib-dir path))
    (message "Not support")))
