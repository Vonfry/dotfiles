;; ivy config -*- lexical-binding: t -*-

(use-package! counsel
  :config
  (ivy-mode 1)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-M-x   'counsel-M-x
        vonfry-keybind-evil-file  'counsel-find-file
        vonfry-keybind-evil-swoop 'swiper
        vonfry-keybind-evil-marks 'counsel-mark-ring
        ))
