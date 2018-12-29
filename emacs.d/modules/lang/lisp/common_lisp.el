;;; common lisp packages -*- lexical-binding: t -*-

(package! slime-company)
(package! slime
  :general
  (nmap :keymaps 'common-lisp-mode-map
        :prefix +nmap-lang-prefix
        "" '(nil :which-key "emacs lisp")
        +nmap-repl  'slime)
  :config
  (setq inferior-lisp-program "sbcl") ;; set to other in custom.el
  (setq slime-contribs '(slime-fancy))
  :hook
  (slime-load .
    (lambda ()
      (package! slime-company
        :config
        (slime-setup '(slime-fancy slime-company)))
      (define-key slime-prefix-map (kbd "M-h") 'slime-documentation-lookup))))
