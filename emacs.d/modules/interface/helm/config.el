;;; helm config -*- lexical-binding: t -*-

(vonfry|use-package! helm
  :init
  (require 'helm-config)
  :config
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
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
  :general
  (nmap :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-M-x    'helm-M-x
        vonfry-keybind-evil-file   'helm-find-files))

(vonfry|use-package! helm-make
  :after helm
  :config
  (custom-set-variables
    '(helm-make-fuzzy-matching t))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-run 'helm-make))

(vonfry|use-package! helm-descbinds-mode
  :after helm
  :config
  (helm-descbinds-mode))

(vonfry|use-package! helm-dash
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

(vonfry|use-package! helm-flyspell
  :init
  (require 'flyspell)
  (require 'ispell)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  :config
  (nmap :prefix vonfry-keybind-evil-leader
        "s" 'helm-flyspell-correct))
