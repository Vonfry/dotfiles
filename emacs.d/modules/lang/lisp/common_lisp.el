;;; common lisp packages -*- lexical-binding: t -*-

(use-package! slime
  :config
  (setq inferior-lisp-program "sbcl") ;; set to other in custom.el
  (setq slime-contribs '(slime-fancy))
  (add-hook 'lisp-mode-hook
    (lambda ()
      (nmap :keymaps 'local
            :prefix vonfry-keybind-evil-leader
            vonfry-keybind-evil-repl 'slime)))
  (add-hook 'slime-load-hook
    (lambda ()
      (define-key slime-prefix-map (kbd "M-h") 'slime-documentation-lookup))))

(use-package! slime-company
  :config
  (slime-setup '(slime-fancy slime-company)))
