;;; mail/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +mail-local-file (expand-file-name "mail.el" vonfry-custom-dir)
  "A local config for mail, loads by `load'. It can be missing. "
  :type 'file
  :group 'vonfry-modules)
