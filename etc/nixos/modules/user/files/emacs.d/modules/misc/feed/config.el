;;; elfeed config -*- lexical-binding: t -*-
;;

(defcustom +feed-local-file (expand-file-name "feed.el" vonfry-local-dir)
  "A local config for feed, loads by `load'. It can be missing. "
  :type 'file
  :group 'vonfry-modules)
