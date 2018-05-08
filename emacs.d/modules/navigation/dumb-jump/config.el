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
        vonfry-keybind-evil-jump-prompt 'dumb-jump-go-prompt)
  (nmap :prefix +dumb-jump-nmap-prefix
        "." 'dumb-jump-go
        "," 'dumb-jump-back
        "/" 'dumb-jump-go-prompt
        ">" 'dumb-jump-quick-look
        "o" 'dumb-jump-go-other-window
        ";" 'dumb-jump-go-prompt
        "<" 'dumb-jump-go-prefer-external
        ":" 'dumb-jump-go-prefer-external-other-window)
  :custom
  (dumb-jump-selector 'ivy))
