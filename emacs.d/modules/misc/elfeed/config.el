;;; elfeed config -*- lexical-binding: t -*-
;;

(defcustom +elfeed-org-files (list (expand-file-name "feed.org" vonfry-local-dir))
  "elfeed-org-files save dir"
  :type '(list string)
  :group 'vonfry-modules)
