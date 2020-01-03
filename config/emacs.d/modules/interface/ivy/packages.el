;;; ivy packages -*- lexical-binding: t -*-
;;

(package! amx
  :custom
  (amx-save-file (expand-file-name "amx-items" vonfry-cache-dir)))

(package! flx
  :defer t
  :custom
  (ivy-flx-limit 10000))

(package! ivy
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers t)
  :general
  (+mmap-leader-def
    "b" 'ivy-switch-buffer))

(package! swiper
  :custom
  (swiper-action-recenter t)
  :general
  (+mmap-leader-def
    "/" 'swiper))

(package! counsel
  :custom
  (counsel-find-file-at-point t)
  :config
  (counsel-mode 1)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  ("C-&" 'counsel-company)
  (+mmap-leader-def
    "x" 'counsel-M-x
    "f" 'counsel-find-file
    "F" 'counsel-fzf
    "m" 'counsel-mark-ring)
  (+mmap-mode-org-def
    "f" 'counsel-org-file))

(package! ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))

(package! counsel-tramp
  :after counsel)
