;;; evil config -*- lexical-binding: t -*-

(vonfry|use-package! evil
  :init
  (defcustom +evil-window-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-window)
    "evil nmap with window"
    :group 'vonfry-module)
  :config
  (evil-mode 1)
  (custom-set-variables
    '(evil-shift-width 4))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-terminal      'shell
        vonfry-keybind-evil-marks         'evil-show-marks)
  (nmap :prefix +evil-window-nmap-prefix
        "w" 'delete-window
        "o" 'delete-other-window))

(vonfry|use-package! evil-numbers
  :bind
  ("C-c +" evil-numbers/inc-at-pt)
  ("C-c -" evil-numbers/dec-at-pt))

(vonfry|use-package! evil-surround
  :config
  (global-evil-surround-mode 1))

(vonfry|use-package! evil-visualstar
  :config
  (global-evil-visualstar-mode t))

(vonfry|use-package! evil-snipe
  :config
  (evil-snipe-mode 1))

(vonfry|use-package! evil-matchit
  :config
  (global-evil-matchit-mode 1))

(vonfry|use-package! evil-lion
    :config
    (evil-lion-mode t))
