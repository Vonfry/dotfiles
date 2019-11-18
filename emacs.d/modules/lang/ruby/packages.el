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
  (+nmap-ruby-def
    "'"   'inf-ruby)
  (+nmap-lang-ruby-def
    "i d" 'ruby-send-definition)
  (+vmap-lang-ruby-def
    "i r" 'ruby-send-region
    "i g" 'ruby-send-definition-and-go
    "i G" 'ruby-send-region-and-go))
