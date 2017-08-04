;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal.

(defgroup vonfry-keybinding nil
  "Vonfry's group about keybinding.")

(defcustom vonfry-keybind-evil-M-x "x"
  "M-x"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-jump-to-definition "."
  "jump to definition"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-jump-module ","
  "jump to file or module"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-code ";"
  "show code struct like ebrower and imenu."
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-repl "'"
  "repl"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-only-window "o"
  "close other window"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-close-window "w"
  "close currect window"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-buffer "b"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-make "m"
  "compile or run"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-search "a"
  "ag"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-ctrlp "p"
  "project file search"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-file "f"
  "file search without recursion."
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-tag "t"
  "taglist"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-neotree "n"
  "dir struct"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-doc "d"
  "doc with dash"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-check "q"
  "syntax check, the default is q because of quickfix in vim."
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-undotree "u"
  "undo tree"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-nerdcommenter "c"
  "nerd commenter first key"
  :group 'vonfry-keybinding)

(defcustom vonfry-keybind-evil-terminal "$"
  "show a terminal"
  :group 'vonfry-keybinding)

(when  (fboundp 'toggle-frame-fullscreen)
  (vonfry-system-sets '(darwin (global-set-key (kbd "M-C-f") 'toggle-frame-fullscreen))))

(provide 'core-keybinding)
