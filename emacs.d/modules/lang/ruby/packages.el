;;; ruby packages -*- lexical-binding: t -*-
;;

(package! enh-ruby-mode
  :mode (("Appraisals\\'" . enh-ruby-mode)
         ("\\(Rake\\|Thor\\|Guard\\|Gem\\|Cap\\|Vagrant\\|Berks\\|Pod\\|Puppet\\)file\\'" . enh-ruby-mode)
         ("\\.\\(rb\\|rabl\\|ru\\|builder\\|rake\\|thor\\|gemspec\\|jbuilder\\)\\'" . enh-ruby-mode))
  :interpreter "pry")

(package! ruby-mode
  :interpreter "pry")

(package! inf-ruby
  :custom
  (inf-ruby-default-implementation "pry")
  :hook
  (enh-ruby-mode . inf-ruby-minor-mode)
  :general
  (nmap :keymaps 'enh-ruby-mode-map
        :prefix +nmap-lang-prefix
        "id" 'ruby-send-definition
        +nmap-repl  'inf-ruby)
  (vmap :keymaps 'enh-ruby-mode-map
        :prefix +nmap-lang-prefix
        "ir" 'ruby-send-region
        "ig" 'ruby-send-definition-and-go
        "iG" 'ruby-send-region-and-go))

(package! chruby
  :general
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix  +nmap-lang-prefix
        "c" 'chruby-use))

