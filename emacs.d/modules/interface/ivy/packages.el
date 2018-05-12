;;; ivy packages -*- lexical-binding: t -*-
;;

(package! ivy)
(package! swiper)
(package! counsel
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-M-x   'counsel-M-x
        vonfry-keybind-evil-file  'counsel-find-file
        vonfry-keybind-evil-swoop 'swiper
        vonfry-keybind-evil-marks 'counsel-mark-ring
        vonfry-keybind-evil-buffer-switch 'ivy-switch-buffer))
