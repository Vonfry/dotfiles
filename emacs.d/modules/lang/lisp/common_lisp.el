;;; common lisp packages -*- lexical-binding: t -*-

(use-package! slime
  :config
  (setq inferior-lisp-program "sbcl") ;; set to other in custom.el
  (setq slime-contribs '(slime-fancy))
  :hook
  ((lisp-mode .
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'slime)))
  (slime-load .
    (lambda ()
      (use-package! slime-company
        :config
        (slime-setup '(slime-fancy slime-company)))
      (define-key slime-prefix-map (kbd "M-h") 'slime-documentation-lookup)))))
