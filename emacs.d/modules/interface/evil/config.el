;;; evil config -*- lexical-binding: t -*-

(vonfry-use-package! 'evil
  :config
  (evil-mode 1)
  (custom-set-variables
    '(evil-shift-width 4))
  (vonfry-use-package! 'evil-surround
    :config
    (evil-mode 1))
  (vonfry-use-package! 'evil-visualstar
    :config
    (global-evil-visualstar-mode))
  (vonfry-use-package! 'evil-numbers
    :bind
    ("C-c +" 'evil-numbers/inc-at-pt)
    ("C-c -" 'evil-numbers/dec-at-pt))
  (vonfry-use-package! 'evil-snipe
    :config
    (evil-snipe-mode 1))
  (vonfry-use-package! 'evil-matchit
    :config
    (global-evil-matchit-mode 1))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-close-window  'delete-windows
        vonfry-keybind-evil-only-window   'delete-other-windows
        vonfry-keybind-evil-terminal      'shell
        vonfry-keybind-evil-marks         'evil-show-marks))

