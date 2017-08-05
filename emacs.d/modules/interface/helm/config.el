;;; helm config -*- lexical-binding: t -*-

(vonfry|use-package! helm
  :bind (("M-x"     helm-M-x)
         ("C-x r b" helm-filtered-bookmarks)
         ("C-x C-f" helm-find-files))
  :config
  (require 'helm-config)
  (helm-mode 1)
  (custom-set-variables
    '(helm-mode-fuzzy-match                 t)
    '(helm-completion-in-region-fuzzy-match t)
    '(helm-recentf-fuzzy-match              t)
    '(helm-buffers-fuzzy-matching           t)
    '(helm-recentf-fuzzy-match              t)
    '(helm-buffers-fuzzy-matching           t)
    '(helm-locate-fuzzy-match               t)
    '(helm-M-x-fuzzy-match                  t)
    '(helm-semantic-fuzzy-match             t)
    '(helm-imenu-fuzzy-match                t)
    '(helm-apropos-fuzzy-match              t)
    '(helm-lisp-fuzzy-completion            t))
  (vonfry|use-package! helm-descbinds-mode
    :config
    (helm-descbinds-mode))
  (vonfry|use-package! helm-ag
    :general
    (mmap :prefix vonfry-keybind-evil-leader
      vonfry-keybind-evil-search 'helm-ag))
  :general
  (mmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-M-x    'helm-M-x
    vonfry-keybind-evil-file   'helm-find-files))
