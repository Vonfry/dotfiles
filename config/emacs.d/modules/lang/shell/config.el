;;; shell config -*- lexical-binding: t -*-
;;

(custom! +shell-terminal-command
  (vonfry-system-sets (gnu/linux "alacritty")
                      (darwin "open /Applications/iTerm.app"))
  "The terminal command is used to open a new window in current directory for linux."
  :type 'string
  :group 'vonfry-modules)

(custom! +shell-terminal-extra-arguments ""
  "Extra arguments for linux"
  :type 'string
  :group 'vonfry-modules)

(custom! +shell-terminal-args-pwd
         (vonfry-system-sets (gnu/linux
                              (cond ((string= +shell-terminal-command
                                              "alacritty")
                                     "--working-directory")
                              (t nil))))

  "The argument add before pwd which lets the terminal set pwd for linux."
  :type 'string
  :group 'vonfry-modules)
