;;; ruby packages -*- lexical-binding: t -*-
;;

(package! ruby-mode
  :interpreter "pry"
  :mode "\\.\\(?:a?rb\\|aslsx\\)\\'"
  :mode "/\\(?:Brew\\|Fast\\)file\\'")

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
