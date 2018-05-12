;;; undotree config -*- lexical-binding: t -*-
;;

(defcustom +undotree-nmap-prefix
  vonfry-keybind-evil-leader
  "undotree evil prefix key"
  :type 'string
  :group 'vonfry-modules)
(defcustom +undotree-history-directory
  (expand-file-name "undotree/" vonfry-local-dir)
  "undotree history directory"
  :type 'string
  :group 'vonfry-modules)
