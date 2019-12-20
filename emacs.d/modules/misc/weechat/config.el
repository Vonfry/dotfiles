;;; weechat config -*- lexical-binding: t -*-
;;

(defcustom +weechat-local-config-file
  (let* ((cloud-path (getenv "CLOUDDISK_DIR"))
         (file (expand-file-name "dotfiles/emacs/weechat" cloud-path)))
    (if (file-exists-p file)
        cloud-file-path
      nil))
  "weechat private config file."
  :group 'vonfry-module)
