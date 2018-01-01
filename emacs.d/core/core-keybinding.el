;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal. I don't use `general-default-prefix` to
;; set leader because there are some normal bind withou leader.

(defcustom vonfry-keybind-evil-leader "<SPC>"
  "Leader key"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-M-x "x"
  "M-x"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-to-definition "."
  "jump to definition"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-back ","
  "jump back for jump-to-tefinition."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-to-others ">"
  "jump to with a prompt look or reference. Reference may only work for C/C++"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-pop-back "<"
  "bind emacs `pop-tag-mark`. It may have the same action as `vonfry-keybind-evil-jump-back`"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump "j"
  "jump function"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-code ";"
  "show code struct like ebrower and imenu."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-swoop ":"
  "show lines matched with swoop"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-prompt "/"
  "jump to file or module with a prompt to search it. It is similiar to imenu."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-code-help "?"
  "pop a window to show help for some code."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-module "#"
  "jump to file or module, or jump back. In some module, such as C, it is used to switch between head and source file.
In global env, it is jump back with jump-to-tefinition."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-speedbar "&"
  "show code struct like ebrower and imenu."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-repl "'"
  "repl"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-buffer "b"
  "buffer"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-marks "m"
  "marks"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-book-marks "k"
  "book marks"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-run "r"
  "compile or run"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-search "a"
  "ag"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-ctrlp "p"
  "project file search"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-file "f"
  "file search without recursion."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-tag "t"
  "taglist"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-treenode "n"
  "dir struct"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-doc "d"
  "doc with dash"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-check "q"
  "syntax check, the default is q because of quickfix in vim."
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-undotree "u"
  "undo tree"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-switch-window "o"
  "switch-window"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-window "w"
  "manage window"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-nerdcommenter "c"
  "nerd commenter first key"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-gtags "g"
  "ggtags"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-lang "z"
  "lang configure"
  :type 'string
  :group 'vonfry-keybind)

(defcustom +lang-nmap-prefix (concat vonfry-keybind-evil-leader vonfry-keybind-evil-lang)
  "lang nmap prefix"
  :type 'string
  :group 'vonfry-module)

(defcustom vonfry-keybind-evil-virtual "v"
  "vitrual machine such as docker"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-terminal "$"
  "show a terminal"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-version-control "-"
  "show a terminal"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-todo "~"
  "show todo mode or org projectile"
  :type 'string
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-feed "+"
  "show todo mode or org projectile"
  :type 'string
  :group 'vonfry-keybind)

(use-package! general
  :config
  (custom-set-variables
    '(general-default-prefix  nil)
    '(general-vim-definer-default 'states))
  (general-evil-setup t t))

(provide 'core-keybinding)
