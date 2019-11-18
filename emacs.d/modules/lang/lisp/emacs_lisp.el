;;; lisp/emacs_lisp.el -*- lexical-binding: t -*-

(defconst +elisp-keymaps '(emacs-lisp-mode-map lisp-interaction-mode-map))

;; +nmap-lang-elisp-def
(vonfry-def-nmap-lang-prefix elisp nil
  :keymaps +elisp-keymaps)

;; +nmap-elisp-def
(vonfry-def-nmap-leader-prefix elisp nil
  :keymaps +elisp-keymaps)

(package! ielm :straight nil
  :general
  (+nmap-lang-elisp-def
    "'"  'ielm)
  (+nmap-leader-def
    "'"  'ielm))

