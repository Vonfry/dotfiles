;;; common lisp packages -*- lexical-binding: t -*-

(use-package! slime
  :config
  (setq inferior-lisp-program "sbcl") ;; set to other in custom.el
  (setq slime-contribs '(slime-fancy))
  :hook
  (slime-load .
    (lambda ()
      (use-package! slime-company
        :config
        (slime-setup '(slime-fancy slime-company)))
      (define-key slime-prefix-map (kbd "M-h") 'slime-documentation-lookup))))
