;;; elfeed config -*- lexical-binding: t -*-
;;


(defcustom +feed-db-directory
  (expand-file-name "elfeed/db" vonfry-local-dir)
  :group 'vonfry-modules
  :type 'directory)

(defcustom +feed-enclosure-directory
  (expand-file-name "elfeed/enclosure" vonfry-local-dir)
  :group 'vonfry-modules
  :type 'directory)
