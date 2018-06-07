;;; ruby packages -*- lexical-binding: t -*-
;;

(package! enh-ruby-mode
  :mode (("Appraisals\\'" . enh-ruby-mode)
         ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Cap\\|Vagrant\\|Berks\\|Pod\\|Puppet\\)file\\'" . enh-ruby-mode)
         ("\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'" . enh-ruby-mode)))

(package! ruby-mode
  :interpreter "pry")

(package! inf-ruby
  :custom
  (inf-ruby-default-implementation "pry")
  :hook
  (enh-ruby-mode . inf-ruby-minor-mode)
  :general
  (nmap :keymaps 'enh-ruby-mode-map
        :prefix +lang-nmap-prefix
        "id" 'ruby-send-definition)
  (vmap :keymaps 'enh-ruby-mode-map
        :prefix +lang-nmap-prefix
        "ir" 'ruby-send-region
        "ig" 'ruby-send-definition-and-go
        "iG" 'ruby-send-region-and-go))

(package! robe
  :hook
  ((enh-ruby-mode . robe-mode)
  (robe-mode . robe-start)
  (robe-mode . (lambda () (add-to-list (make-local-variable 'company-backends) 'company-robe))))
  :general
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix +lang-nmap-prefix
        "." 'robe-jump
        "," 'robe-ask
        "?" 'robe-doc
        "#" 'robe-jump-to-module)
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix vonfry-keybind-evil-leader
        vonfry-keybind-evil-code-help 'robe-doc
        vonfry-keybind-evil-jump-module 'robe-jump-to-module))

(package! chruby
  :general
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix +lang-nmap-prefix
        "c" 'chruby-use))

