;;; ruby packages -*- lexical-binding: t -*-
;;

(package! enh-ruby-mode
  :mode (("Appraisals\\'" . enh-ruby-mode)
         ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Cap\\|Vagrant\\|Berks\\|Pod\\|Puppet\\)file\\'" . enh-ruby-mode)
         ("\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'" . enh-ruby-mode)))

(package! inf-ruby
  :hook
  (enh-ruby-mode . inf-ruby-minor-mode))

(package! robe
  :hook
  ((enh-ruby-mode . robe-mode)
  (robe-mode . robe-start))
  (robe-mode . (lambda () (add-to-list (make-local-variable 'company-backends) 'company-robe)))
  :general
  (nmap :keymaps 'robe-mode
        :prefix +lang-nmap-prefix
        "." 'robe-jump
        "," 'robe-ask
        "?" 'robe-doc
        "#" 'robe-jump-to-module)
  (nmap :keymaps 'local
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code-help 'robe-doc
        vonfry-keybind-evil-jump-module 'robe-jump-to-module))

(package! chruby
  :general
  (nmap :keymaps 'robe-mode
        :prefix +lang-nmap-prefix
        "c" 'chruby-use))

