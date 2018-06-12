;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal. I don't use `general-default-prefix` to
;; set leader because there are some normal bind without leader.
;;
;; All local map set for major or minor mode map by default. Only if the minor mode hasn't a map, such as robe, using
;; evil minor mode map instead which use a hook to add into local map.
;; All keybind use general.el to manage.
;;
;; The only one you can customize is leader key. The others are the public key using whole space.
;; All keys combine with leader when setting, this can have a more structed definitation.

(defcustom vonfry-keybind-evil-leader "<SPC>"
  "Leader key"
  :type 'string
  :set
  (lambda (sym newvalue)
    (defconst +nmap-leader newvalue "leader key")
    (set-default sym newvalue))
  :group 'vonfry-keybind)

(defconst +nmap-M-x "x"
  "M-x")

(defconst +nmap-go "."
  "goto")

(defconst +nmap-go-back ","
  "go back")

(defconst +nmap-go-peek "{"
  "go peek")

(defconst +nmap-go-reference "}"
  "Go eference. Reference may only work for C/C++")

(defconst +nmap-code ";"
  "show code struct like ebrower and imenu.")

(defconst +nmap-swiper "/"
  "show lines matched with swiper/swoop")

(defconst +nmap-go-prompt ">"
  "go to file or module with a prompt to search it. It is similiar to imenu.")

(defconst +nmap-code-help "?"
  "pop a window to show help for some code.")

(defconst +nmap-go-module "#"
  "go to file or module, or jump back. In some module, such as C, it is used to switch between head and source file. ")

(defconst +nmap-format "("
  "format code")

(defconst +nmap-align "="
  "align regex")

(defconst +nmap-speedbar "&"
  "show code struct like ebrower and imenu.")

(defconst +nmap-repl "'"
  "repl")

(defconst +nmap-lang-action "*"
  "some lang public action, such as lsp")

(defconst +nmap-navigation "["
  "Go to somewhere.")

(defconst +nmap-g "g"
  "Go to text/char")

(defconst +nmap-buffer-switch "b"
  "buffer")

(defconst +nmap-buffer "B"
  "buffer")

(defconst +nmap-marks "m"
  "marks")

(defconst +nmap-book-marks "K"
  "book marks")

(defconst +nmap-run "r"
  "compile or run")

(defconst +nmap-search "a"
  "ag or other search tools")

(defconst +nmap-ctrlp "p"
  "project file search")

(defconst +nmap-file "f"
  "file search without recursion.")

(defconst +nmap-tag "t"
  "taglist")

(defconst +nmap-treenode "d"
  "dir struct")

(defconst +nmap-check "q"
  "syntax check, the default is q because of quickfix in vim.")

(defconst +nmap-undotree "u"
  "undo tree")

(defconst +nmap-window "w"
  "manage window")

(defconst +nmap-commenter "c"
  "nerd commenter first key")

(defconst +nmap-virtual "v"
  "vitrual machine such as docker")

(defconst +nmap-terminal "$"
  "show a terminal")

(defconst +nmap-version-control "-"
  "show a terminal")

(defconst +nmap-highlight "h"
  "manage some highlight setting")

(defconst +nmap-todo "~"
  "show todo mode or org projectile")

(defconst +nmap-lang "z"
  "lang configure")

(defconst +nmap-lang-prefix (concat +nmap-leader +nmap-lang)
  "lang nmap prefix")


(package! general
  :config
  (custom-set-variables
   '(general-default-prefix  nil)
   '(general-vim-definer-default 'states))
  (general-evil-setup t t))

(provide 'core-keybinding)
