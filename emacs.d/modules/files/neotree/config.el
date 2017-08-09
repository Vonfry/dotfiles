;;; neotree packages -*- lexical-binding: t -*-

(vonfry|use-package! neotree
  :config
  (custom-set-variables
    '(neo-theme (if (display-graphic-p) 'icons 'arrow))
    '(neo-smart-open t))
  (add-hook 'neotree-mode-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
      (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
      (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
      (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)
      (define-key evil-normal-state-local-map (kbd "p") 'neotree-select-up-node)
      (define-key evil-normal-state-local-map (kbd "b") 'neotree-select-down-node)
      (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
      (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)
      (define-key evil-normal-state-local-map (kbd "r") 'neotree-rename-node)))
  :general
  (nmap :prefix vonfry-keybind-evil-leader
    vonfry-keybind-evil-neotree 'neotree-toggle))
