;;; shell config -*- lexical-binding: t -*-
;;

(custom! +shell-terminal-command "alacritty"
  "The terminal command is used to open a new window in current directory."
  :type 'string
  :group 'vonfry-modules)

(custom! +shell-terminal-extra-arguments ""
  "Extra arguments"
  :type 'string
  :group 'vonfry-modules)

(custom! +shell-terminal-args-pwd
         (cond ((string= +shell-terminal-command "alacritty")
                "--working-directory")
                (t nil))
  "The argument add before pwd which lets the terminal set pwd."
  :type 'string
  :group 'vonfry-modules)
