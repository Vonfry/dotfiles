;;; javascript config -*- lexical-binding: t -*-

(vonfry|use-package! js2-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook 'js2-imenu-extras-mode))

(vonfry|use-package! json-mode :after js2-mode)

(vonfry|use-package! tern
  :config
  (add-hook 'js2-mode-hook 'tern-mode)
  (add-hook 'js2-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
             vonfry-keybind-evil-jump 'tern-find-definition-by-name
             vonfry-keybind-evil-jump-module 'tern-pop-find-definition)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            ";" 'tern-find-definition
            "." 'tern-find-definition-by-name
            "," 'tern-pop-find-definition
            "t" 'tern-get-type
            "d" 'tern-get-docs))))

(vonfry|use-package! company-tern
  :after tern company
  :config
  (add-hook 'js2-mode-hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends) 'company-tern))))
