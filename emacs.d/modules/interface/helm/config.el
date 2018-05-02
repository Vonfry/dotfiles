;; helm config -*- lexical-binding: t -*-

(use-package! helm
  :init
  (require 'helm-config)
  :config
  (helm-mode 1)
  :custom
  (helm-mode-fuzzy-match                 t)
  (helm-completion-in-region-fuzzy-match t)
  (helm-recentf-fuzzy-match              t)
  (helm-buffers-fuzzy-matching           t)
  (helm-recentf-fuzzy-match              t)
  (helm-buffers-fuzzy-matching           t)
  (helm-locate-fuzzy-match               t)
  (helm-M-x-fuzzy-match                  t)
  (helm-semantic-fuzzy-match             t)
  (helm-imenu-fuzzy-match                t)
  (helm-apropos-fuzzy-match              t)
  (helm-lisp-fuzzy-completion            t)
  :general
  ("M-x" 'helm-M-x)
  ("C-x r b" 'helm-filtered-bookmarks)
  ("C-x C-f" 'helm-find-files)
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-M-x    'helm-M-x
        vonfry-keybind-evil-file   'helm-find-files))

(use-package! helm-make
  :after helm
  :custom
  (helm-make-fuzzy-matching t)
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-run 'helm-make))

(use-package! helm-descbinds
  :after helm
  :config
  (helm-descbinds-mode))

(use-package! helm-swoop
  :after helm
  :init
  (defcustom +helm-swoop-nmap-prefix (concat vonfry-keybind-evil-leader vonfry-keybind-evil-swoop)
    "helm-swoop prefix key"
    :type 'string
    :group 'vonfry-modules)
  :general
  (nmap :prefix +helm-swoop-nmap-prefix
        "s" 'helm-swoop
        "m" 'helm-multi-swoop
        "p" 'helm-multi-swoop-projectile))

(use-package! helm-dash
  :after helm
  :init
  (defcustom +helm-dash-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-doc)
    "helm-dash prefix key"
    :type 'string
    :group 'vonfry-modules)
  :config
  (setq helm-dash-common-docsets '("Bash" "Docker"))
  (setq helm-dash-browser-func 'eww)
  (defun +helm-dash-set-dash (&rest docs)
    (setq helm-dash-docsets docs))
  :general
  (nmap :prefix +helm-dash-nmap-prefix
        "d" 'helm-dash
        "." 'helm-dash-at-point
        "a" 'helm-dash-activate-docset))

(use-package! helm-flyspell
  :init
  (require 'flyspell)
  (require 'ispell)
  :hook
  (prog-mode . flyspell-prog-mode)
  :config
  (nmap :prefix vonfry-keybind-evil-leader
        "s" 'helm-flyspell-correct))
