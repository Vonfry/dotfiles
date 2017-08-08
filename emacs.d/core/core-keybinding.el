;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal.

(defcustom vonfry-keybind-evil-leader "<SPC>"
  "Leader key"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-M-x "x"
  "M-x"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-to-definition "."
  "jump to definition"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump-module ","
  "jump to file or module, or jump back. In some module, such as C, it is used to switch between head and source file.
In global env, it is jump back with jump-to-tefinition."
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-jump "j"
  "jump function"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-code ";"
  "show code struct like ebrower and imenu."
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-repl "'"
  "repl"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-buffer "b"
  "buffer"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-marks "m"
  "marks"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-run "r"
  "compile or run"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-search "a"
  "ag"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-ctrlp "p"
  "project file search"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-file "f"
  "file search without recursion."
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-tag "t"
  "taglist"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-neotree "n"
  "dir struct"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-doc "d"
  "doc with dash"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-check "q"
  "syntax check, the default is q because of quickfix in vim."
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-undotree "u"
  "undo tree"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-switch-window "o"
  "switch-window"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-window "w"
  "manage window"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-nerdcommenter "c"
  "nerd commenter first key"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-gtags "g"
  "ggtags"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-lang "z"
  "lang configure"
  :group 'vonfry-keybind)

(defcustom +lang-nmap-prefix (concat vonfry-keybind-evil-leader vonfry-keybind-evil-lang)
  "lang nmap prefix"
  :group 'vonfry-module)

(defcustom vonfry-keybind-evil-virtual "v"
  "vitrual machine such as docker"
  :group 'vonfry-keybind)

(defcustom vonfry-keybind-evil-terminal "$"
  "show a terminal"
  :group 'vonfry-keybind)

(when  (fboundp 'toggle-frame-fullscreen)
  (vonfry-system-sets '(darwin (global-set-key (kbd "M-C-f") 'toggle-frame-fullscreen))))

(vonfry|use-package! general
  :config
  (setq general-default-keymaps 'evil-normal-state-map)
  (setq general-default-prefix  nil)
  (general-evil-setup t))

(provide 'core-keybinding)
