;;; ruby packages -*- lexical-binding: t -*-
;;

(package! enh-ruby-mode
  :mode ("\\.\\(?:pry\\|irb\\)rc\\'" . enh-ruby-mode)
  :mode ("\\.\\(?:rb\\|rake\\|rabl\\|ru\\|builder\\|gemspec\\|jbuilder\\|thor\\)\\'" . enh-ruby-mode)
  :mode ("/\\(?:Berks\\|Cap\\|Gem\\|Guard\\|Pod\\|Puppet\\|Rake\\|Thor\\|Vagrant\\)file\\'" . enh-ruby-mode)
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
