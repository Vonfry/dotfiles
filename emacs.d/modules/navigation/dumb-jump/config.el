;;; dumb-jump config -*- lexical-binding: t -*-

(use-package! dumb-jump
  :init
  (defcustom +dumb-jump-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-jump)
    "dumb jump nmap"
    :type 'string
    :group 'vonfry-modules)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-jump-to-definition 'dumb-jump-go
        vonfry-keybind-evil-jump-prompt        'dumb-jump-go-prompt
        vonfry-keybind-evil-jump-to-others     'dumb-jump-quick-look
        vonfry-keybind-evil-jump-back          'dumb-jump-back)
  (nmap :prefix +dumb-jump-nmap-prefix
        "." 'dumb-jump-go
        "," 'dumb-jump-back
        "/" 'dumb-jump-go-prompt
        ">" 'dumb-jump-quick-look
        "o" 'dumb-jump-go-other-window
        "i" 'dumb-jump-go-prompt
        "x" 'dumb-jump-go-prefer-external
        "z" 'dumb-jump-go-prefer-external-other-window)
  :config
  (custom-set-variables
    '(dumb-jump-selector 'helm)))
