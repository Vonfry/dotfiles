;;; elfeed config -*- lexical-binding: t -*-
;;

(defcustom +elfeed-org-files (list (expand-file-name "feed.org" vonfry-cache-dir))
  "elfeed-org-files save dir"
  :type '(repeat string)
  :group 'vonfry-modules)
