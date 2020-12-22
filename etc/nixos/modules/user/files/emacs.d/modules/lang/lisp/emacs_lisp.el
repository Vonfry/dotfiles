;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

;; +mmap-elisp-def
(package! ielm :ensure nil
  :general
  (nmap-leader :keymps 'emacs-lisp-mode
    "\""  'ielm
    "' b" 'eval-buffer
    "' r" 'eval-region))

(hook! elisp-mode (progn
                    (vonfry/local-indent 2)
                    (+company-set-backends-grouped 'company-elisp)))
