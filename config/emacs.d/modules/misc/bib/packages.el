;;; bib packages -*- lexical-binding: t -*-
;;

(package! ebib
  :custom
  (ebib-filters-default-file (expand-file-name "ebib/filters" vonfry-cache-dir))
  (ebib-file-associations (vonfry-system-sets
                           (darwin '(("pdf" . "open")))
                           (gnu/linux '(("pdf" . "zathura"))))))
