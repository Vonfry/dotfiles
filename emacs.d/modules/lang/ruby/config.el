;;; ruby config -*- lexical-binding: t -*-

(use-package! enh-ruby-mode
  :mode (("Appraisals\\'" . enh-ruby-mode)
         ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Cap\\|Vagrant\\|Berks\\|Pod\\|Puppet\\)file\\'" . enh-ruby-mode)
         ("\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'" . enh-ruby-mode)))

(use-package! inf-ruby
  :config
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-console-auto)
  (add-hook 'enh-ruby-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'inf-ruby))))

(use-package! robe
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode)
  (add-hook 'robe-mode-hook 'robe-start)
  (add-hook 'robe-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "." 'robe-jump
            "," 'robe-ask
            "?" 'robe-doc
            "#" 'robe-jump-to-module)
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-jump 'robe-jump
            vonfry-keybind-evil-jump-to-others 'robe-ask
            vonfry-keybind-evil-code-help 'robe-doc
            vonfry-keybind-evil-jump-module 'robe-jump-to-module)
      (add-to-list (make-local-variable 'company-backends) 'company-robe))))

(use-package! chruby
  :config
  (add-hook 'robe-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "c" 'chruby-use))))

