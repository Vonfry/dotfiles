;;; winner mode packages -*- lexical-binding: t -*-

(winner-mode t)

(defcustom +winner-mode-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-window)
    "winner-mode nmap prefix"
    :type 'string
    :group 'vonfry-modules)
(nmap :prefix +winner-mode-nmap-prefix
      "r" 'winner-mode-redo
      "u" 'winner-mode-undo)
