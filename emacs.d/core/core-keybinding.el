;;; core/core-keybinding.el -*- lexical-binding: t -*-
;;
;; This file doesn't set a lot of keybindinds, because the plugins are setting in modules and they cannot be set here.
;; If using hooks, I think it isn't beautiful enough. So the file only defines some keys which are bounded to use.
;;
;; The name with evil means that the keybind use with <leader> in evil-normal.

(defconst vonfry-keybind-evil-leader "<SPC>"
  "Leader key")

(defconst vonfry-keybind-evil-M-x "x"
  "M-x")

(defconst vonfry-keybind-evil-jump-to-definition "."
  "jump to definition")

(defconst vonfry-keybind-evil-jump-module ","
  "jump to file or module")

(defconst vonfry-keybind-evil-code ";"
  "show code struct like ebrower and imenu.")

(defconst vonfry-keybind-evil-repl "'"
  "repl")

(defconst vonfry-keybind-evil-only-window "o"
  "close other window")

(defconst vonfry-keybind-evil-close-window "w"
  "close currect window")

(defconst vonfry-keybind-evil-buffer "b")

(defconst vonfry-keybind-evil-marks "m"
  "marks")

(defconst vonfry-keybind-evil-run "r"
  "compile or run")

(defconst vonfry-keybind-evil-search "a"
  "ag")

(defconst vonfry-keybind-evil-ctrlp "p"
  "project file search")

(defconst vonfry-keybind-evil-file "f"
  "file search without recursion.")

(defconst vonfry-keybind-evil-tag "t"
  "taglist")

(defconst vonfry-keybind-evil-neotree "n"
  "dir struct")

(defconst vonfry-keybind-evil-doc "d"
  "doc with dash")

(defconst vonfry-keybind-evil-check "q"
  "syntax check, the default is q because of quickfix in vim.")

(defconst vonfry-keybind-evil-undotree "u"
  "undo tree")

(defconst vonfry-keybind-evil-nerdcommenter "c"
  "nerd commenter first key")

(defconst vonfry-keybind-evil-terminal "$"
  "show a terminal")

(when  (fboundp 'toggle-frame-fullscreen)
  (vonfry-system-sets
    '(darwin
      (global-set-key (kbd "M-C-f") 'toggle-frame-fullscreen)
      (custom-set-variables
        (mac-command-modifier 'meta)
        (mac-option-modifier 'super)
        (default-input-method "MacOS"))
      (dolist (multiple '("" "double-" "triple-"))
        (dolist (direction '("right" "left"))
          (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore))))))

(vonfry-use-package! 'general
  :config
  (setq general-default-keymaps 'evil-normal-state-map)
  (setq general-default-prefix  nil)
  (general-evil-setup t))

(provide 'core-keybinding)
