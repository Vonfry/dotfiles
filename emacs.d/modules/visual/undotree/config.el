;;; undotree config -*- lexical-binding: t -*-
;;

(defcustom +nmap-undotree-prefix
  +nmap-leader
  "undotree evil prefix key")

(defconst +undotree-history-directory
  (expand-file-name "undotree/" vonfry-local-dir)
  "undotree history directory")
