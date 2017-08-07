;;; ggtags config -*- lexical-binding: t -*-

(vonfry|use-package! ggtags
  :config
  (add-hook 'prog-mode-hook 'ggtags-mode)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index))

(vonfry|use-package! helm-gtags
  :init
  (defcustom +helm-gtags-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-gtags)
    "helm-gtags prefix for nmap"
    :group 'vonfry-module)
  (custom-set-variables
    '(helm-gtags-display-style "detail")
    '(helm-gtags-auto-update t)
    '(helm-gtags-fuzzy-match t))
  :config
  (add-hook 'prog-mode-hook 'helm-gtags-mode)
  :general
  (nmap :prefix +helm-gtags-nmap-prefix
        ";" 'helm-gtags-dwim
        "." 'helm-gtags-select
        "c" 'helm-gtags-create-tags
        "u" 'helm-gtags-update-tags
        "f" 'helm-gtags-find-tag
        "p" 'helm-gtags-find-files)
  )
