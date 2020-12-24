;;; shell config -*- lexical-binding: t -*-
;;

(defcustom +shell-terminal-command "alacritty"

  "The terminal command is used to open a new window in current directory for linux."
  :type 'string
  :group 'vonfry-modules)

(defcustom +shell-terminal-extra-arguments ""
  "Extra arguments for linux"
  :type 'string
  :group 'vonfry-modules)

(defcustom +shell-terminal-args-pwd "--working-directory"
  "The argument add before pwd which lets the terminal set pwd for linux."
  :type 'string
  :group 'vonfry-modules)

