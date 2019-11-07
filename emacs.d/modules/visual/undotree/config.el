;;; undotree config -*- lexical-binding: t -*-
;;

(defcustom +undotree-history-directory
  (expand-file-name "undotree/" vonfry-cache-dir)
  "undotree history directory"
  :type 'directory
  :group 'vonfry-modules)
