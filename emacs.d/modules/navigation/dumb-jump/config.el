;;; dump-jump config -*- lexical-binding: t -*-

(vonfry|use-package! dump-jump
  :init
  (defcustom +dump-jump-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-jump)
    "dump jump nmap"
    :type 'string
    :group 'vonfry-module)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-to-definition 'dumb-jump-go
        vonfry-keybind-evil-jump-module        'dumb-jump-back)
  (nmap :prefix +dump-jump-nmap-prefix
        "." 'dumb-jump-go
        "," 'dumb-jump-back
        "o" 'dumb-jump-go-other-window
        "i" 'dumb-jump-go-prompt
        "x" 'dumb-jump-go-prefer-external
        "z" 'dumb-jump-go-prefer-external-other-window)
  :config
  (custom-set-variables
    '(dumb-jump-selector 'helm))
