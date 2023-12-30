;;; gnus/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +gnus-local-file (expand-file-name "gnus.el" vonfry-custom-dir)
  "A local file for gnus private config is loaded automaticly, which can be
 missing."
  :type 'file
  :group 'vonfry-modules)
