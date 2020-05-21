;;; bib config -*- lexical-binding: t -*-
;;

(fun! +bib--set-dir (name val)
  "set bib directory."
  (set-default name val)
  (when val
    (custom-set! ebib-notes-directory val
                 ebib-reading-list (expand-file-name "reading.org" val)
                 +bib-search-dir (add-to-ordered-list
                                   '+bib-search-dir val 0)
                 ebib-file-search-dirs (add-to-ordered-list
                                         'ebib-file-search-dirs val 0))))

(custom! +bib-dir nil
  "bib directory. the bibs in this dir and notes under the same one."
 :group 'vonfry-modules
 :type 'directory
 :set #'+bib--set-dir)

(custom! +bib-search-dir nil
  "bib search dir."
  :group 'vonfry-modules
  :type '(repeat 'directory)
  :custom-set 'ebib-bib-search-dirs)
