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
  :general
  (+mmap-ruby-def
    "\""  'inf-ruby
    "' r" 'ruby-send-region
    "' ." 'ruby-send-definition-and-go
    "' >" 'ruby-send-definition
    "' ," 'ruby-send-region
    "' <" 'ruby-send-region-and-go))

(package! realgud-pry
  :general
  (+mmap-ruby-def
    "R" 'realgud:pry))
