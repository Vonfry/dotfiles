;;; hl-todo config -*- lexical-binding: t; -*-

(use-package! hl-todo
  :init
  (defcustom +hl-todo-prefix-keybind
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-highlight "t")
    "The prefix keybind for evil normal mode to use hl-todo."
    :type 'string
    :group 'vonfry-module)
  :general
  (nmap :prefix vonfry-keybind-evil-highlight
    "p" 'hl-todo-previous
    "n" 'hl-todo-next
    "o" 'hl-todo-occur))
