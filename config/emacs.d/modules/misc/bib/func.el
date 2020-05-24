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
     (let ((path (ivy-read "bib serch dir: " +bib-search-dir
                           :require-match t)))
       (eval `(custom-set! +bib-dir ,path)))
     (let ((path (read-from-minibuffer "bib search dir: " nil nil nil
                                      +bib-search-dir)))
       (eval `(custom-set! +bib-dir ,path)))))
