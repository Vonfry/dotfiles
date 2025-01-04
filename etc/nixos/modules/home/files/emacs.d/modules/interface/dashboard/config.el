;;; dashboard/config.el --- -*- lexical-binding: t -*-
;;

(defcustom +dashboard-pwd (expand-file-name "~")
  "dashboard buffer pwd, it will be entered in `+dashboard/goto'"
  :group 'vonfry-modules
  :type 'directory)
