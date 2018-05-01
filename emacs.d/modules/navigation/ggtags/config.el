;;; ggtags config -*- lexical-binding: t -*-

(use-package! ggtags
  :disabled
  :hook
  (prog-mode . ggtags-mode)
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index))

(use-package! helm-gtags
  :after ggtags
  :init
  (defcustom +helm-gtags-nmap-prefix
    (concat vonfry-keybind-evil-leader vonfry-keybind-evil-gtags)
    "helm-gtags prefix for nmap"
    :type 'string
    :group 'vonfry-modules)
  :custom
  (helm-gtags-display-style "detail")
  (helm-gtags-auto-update t)
  (helm-gtags-fuzzy-match t)
  :hook
  (prog-mode . helm-gtags-mode)
  :general
  (nmap :prefix +helm-gtags-nmap-prefix
        ";" 'helm-gtags-dwim
        "." 'helm-gtags-select
        ">" 'helm-gtags-find-rtag
        "/" 'helm-gtags-find-tag
        "<" 'helm-gtags-pop-stack
        "," 'helm-gtags-find-files
        ":" 'helm-gtags-show-stack
        "c" 'helm-gtags-create-tags
        "u" 'helm-gtags-update-tags))
