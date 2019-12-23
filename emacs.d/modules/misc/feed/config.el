;;; elfeed config -*- lexical-binding: t -*-
;;


(defcustom +feed-db-directory
  (expand-file-name "elfeed/db" vonfry-local-dir)
  "elfeed db directory, see `elfeed-db-directory'"
  :group 'vonfry-modules
  :type 'directory)

(defcustom +feed-enclosure-directory
  (expand-file-name "elfeed/enclosure" vonfry-local-dir)
  "elfeed enclosuer directory, see `elfeed-enclosure-directory'"
  :group 'vonfry-modules
  :type 'directory)
