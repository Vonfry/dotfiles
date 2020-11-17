;;; bib config -*- lexical-binding: t -*-
;;
(const! +bib--set-counter most-negative-fixnum)

(fun! +bib--set-dir (name val)
  "set bib directory."
  (set-default name val)
  (when val
    (when (= +bib--set-counter most-negative-fixnum)
      (setq +bib-search-dir nil
            ebib-file-search-dirs nil))
    (setq +bib--set-counter (1- +bib--set-counter))
    (eval `(custom-set!
            ,@(if +bib-note-is-single
                (list 'ebib-notes-file (expand-file-name "notes.org" val))
                (list 'ebib-notes-directory val))
            ebib-reading-list-file (expand-file-name "reading.org" ,val)
            +bib-search-dir (add-to-ordered-list
                             '+bib-search-dir
                             ,val
                             +bib--set-counter)
            ebib-file-search-dirs (add-to-ordered-list
                                   'ebib-file-search-dirs
                                   ,val
                                   +bib--set-counter)))))

(custom! +bib-note-is-single nil
  "bib notes use a single file or not. see `ebib-notes-directory' and
`ebib-notes-file'"
  :type 'boolean
  :group 'vonfry-modules)

(custom! +bib-dir nil
  "bib directory. the bibs in this dir and notes under the same one."
 :group 'vonfry-modules
 :type 'directory
 :set '+bib--set-dir)

(custom! +bib-search-dir nil
  "bib search dir."
  :group 'vonfry-modules
  :type '(repeat 'directory)
  :custom-set 'ebib-bib-search-dirs)

;; +mmap-mode-bib-def
(mmap-mode-prefix! bib nil
  :keymaps 'bibtex-mode-map)
