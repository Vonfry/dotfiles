;;; ruby config -*- lexical-binding: t -*-

(use-package! enh-ruby-mode
  :mode (("Appraisals\\'" . enh-ruby-mode)
         ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Cap\\|Vagrant\\|Berks\\|Pod\\|Puppet\\)file\\'" . enh-ruby-mode)
         ("\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'" . enh-ruby-mode)))

(use-package! inf-ruby
  :hook
  ((enh-ruby-mode . inf-ruby-minor-mode)
  (enh-ruby-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'inf-ruby)))))

(use-package! robe
  :hook
  ((enh-ruby-mode . robe-mode)
  (robe-mode . robe-start)
  (robe-mode .
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
      (add-to-list (make-local-variable 'company-backends) 'company-robe)))))

(use-package! chruby
  :hook
  (robe-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            "c" 'chruby-use))))

