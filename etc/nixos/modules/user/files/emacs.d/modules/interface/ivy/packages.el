;;; ivy packages -*- lexical-binding: t -*-
;;

(use-package amx
  :custom
  (amx-save-file (expand-file-name "amx-items" vonfry-cache-dir)))

(use-package flx
  :defer t
  :custom
  (ivy-flx-limit 10000))

(use-package ivy
  :config
  (ivy-mode 1)
  :custom
  (ivy-use-virtual-buffers nil))

(use-package counsel
  :custom
  (counsel-find-file-at-point t)
  :config
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist nil)
  :general
  ("M-x" 'counsel-M-x)
  ("C-x r b" 'counsel-bookmark)
  ("C-x C-f" 'counsel-find-file)
  ("C-&" 'counsel-company)
  (nmap-leader :keymaps 'prog-mode-map
    "r" 'counsel-compile)
  (nvmap-leader
    "x" 'counsel-M-x)
  (nmap-leader
    "f" 'counsel-find-file
    "F" '(:ignore t :which-key "counsel misc")
    "F f" 'counsel-fzf
    "F r" 'counsel-recentf
    "F a" 'counsel-rg
    "F ;" 'counsel-outline
    "p" 'counsel-cd
    "b" 'counsel-switch-buffer
    "<" 'counsel-mark-ring
    "?" 'counsel-info-lookup-symbol
    "y" 'counsel-yank-pop
    "m" 'counsel-bookmark
    ";" 'counsel-imenu)
  (nmap-leader :keymaps 'outline-mode-map
    "/" 'counsel-outline)
  (nmap-mode :keymaps 'org-mode-map
    "f" 'counsel-org-file))

(use-package ivy-avy :after (ivy avy))

(use-package swiper
  :custom
  (swiper-action-recenter t)
  :general
  (nmap-leader
    ; use `avy-goto-char-timer' or `evil-search' instead. swiper is slow when
    ;the buffer is large
    "F /" 'swiper))

(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))

(use-package counsel-tramp
  :after counsel)
