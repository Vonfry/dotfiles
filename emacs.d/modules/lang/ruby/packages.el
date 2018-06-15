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
        :prefix +nmap-lang-prefix
        ""   '(nil :major-modes t)
        "id" 'ruby-send-definition)
  (vmap :keymaps 'enh-ruby-mode-map
        :prefix +nmap-lang-prefix
        ""   '(nil :major-modes t)
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
        :prefix  +nmap-lang-prefix
        "" '(nil :major-modes t)
        +nmap-go        'robe-jump
        +nmap-go-prompt 'robe-ask
        +nmap-code-help 'robe-doc
        +nmap-go-module 'robe-jump-to-module)
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix +nmap-leader
        "" '(nil :major-modes t)
        +nmap-code-help 'robe-doc
        +nmap-go-module 'robe-jump-to-module))

(package! chruby
  :general
  (nmap :keymaps 'robe-mode
        :definer 'minor-mode
        :prefix  +nmap-lang-prefix
        ""  '(nil :major-modes t)
        "c" 'chruby-use))

