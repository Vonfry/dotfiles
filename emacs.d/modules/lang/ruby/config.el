;;; ruby config -*- lexical-binding: t -*-

(vonfry|use-package! enhanced-ruby-mode
  :config
  (add-to-list 'auto-mode-alist
               '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))


(vonfry|use-package! inf-ruby
  :config
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-console-auto)
  (add-hook 'enh-ruby-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'inf-ruby))))

(vonfry|use-package! robe
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'robe-start)
  (add-hook 'robe-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            ";" 'robe-ask
            "d" 'robe-doc)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump robe-jump
            vonfry-keybind-evil-jump-module 'robe-jump-to-module)
      (add-to-list (make-local-variable 'company-backends) 'company-robe))))

(vonfry|use-package! chruby
  :config
  (add-hook 'robe-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "c" 'chruby-use))))

