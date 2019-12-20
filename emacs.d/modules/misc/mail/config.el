;;; mail config -*- lexical-binding: t -*-
;;

(defcustom +mail-local-config-file
  (let* ((cloud-path (getenv "CLOUDDISK_DIR"))
         (file (expand-file-name "dotfiles/emacs/mail" cloud-path)))
    (if (file-exists-p file)
        cloud-file-path
      nil))
  "mail private config file."
  :group 'vonfry-module)
