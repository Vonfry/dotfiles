;;; neotree packages -*- lexical-binding: t -*-

(vonfry|use-package! neotree
  :config
  (custom-set-variables
   '(neo-theme (if (display-graphic-p) 'icons 'arrow))
   '(neo-smart-open t)
   '(neo-autorefresh t)
   '(neo-create-file-auto-open t)
   '(neo-auto-indent-point t)
   '(neo-confirm-create-file 'off-p)
   '(neo-confirm-create-directory 'off-p)
   '(neo-confirm-delete-file 'y-or-n-p)
   '(neo-confirm-change-root 'off-p)
   '(neo-confirm-delete-directory-recursively 'y-or-n-p)
   '(neo-confirm-kill-buffers-for-files-in-directory 'off-p))
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
