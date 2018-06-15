;;; fold modules -*- lexical-binding: t; -*-
;;

(package! origami
  :hook ((text-mode prog-mode) . origami-mode)
  :general
  (nmap :prefix +nmap-origaml-prefix
        :keymaps '(text-mode prog-mode)
        ""  '(nil :which-key "origaml")
        "o" 'origami-open-node
        "O" 'origami-open-node-recursively
        "s" 'origami-show-node
        "c" 'origami-close-node
        "C" 'origami-close-node-recursively
        "a" 'origami-toggle-node
        "P" 'origami-forward-toggle-node
        "A" 'origami-recursively-toggle-node
        "r" 'origami-open-all-nodes
        "m" 'origami-close-all-nodes
        "t" 'origami-toggle-all-nodes
        "S" 'origami-show-only-node
        "p" 'origami-previous-fold
        "n" 'origami-next-fold
        "f" 'origami-forward-fold
        "F" 'origami-forward-fold-same-level
        "b" 'origami-backward-fold-same-level
        "u" 'origami-undo
        "d" 'origami-redo
        "e" 'origami-reset))
