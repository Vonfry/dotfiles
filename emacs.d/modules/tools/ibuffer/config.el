;;; ibuffer config -*- lexical-binding: t -*-
;;

(defcustom +ibuffer-filter-groups
  '(("Circe" (or (mode . circe-channel-mode)
                 (mode . circe-query-mode)
                 (mode . circe-server-mode)))
    ("Mu4e"      (name . "\\*mu4e-.*\\*"))
    ("Flycheck"  (name . "\\*Flycheck.*\\*"))
    ("Elfeed"    (name . "\\*elfeed.*\\*"))
    ("Process"   (or (mode . process-menu-mode)
                     (mode . proced-mode)))
    ("Lisp"      (or (mode . lisp-interaction-mode)
                     (mode . ielm-mode)))
    ("Shell"     (or (mode . shell-mode)
                     (mode . eshell-mode)))
    ("Comint"    (derived-mode . comint-mode))
    ("LSP"       (name . "\\*lsp-.*\\*"))
    ("Message"   (or (name . "\\*straight.*\\*")
                     (name . "\\*Messages\\*")
                     (name . "\\*direnv\\*")
                     (mode . help-mode))))
  "ibuffer groups, because of `ibuffer-projectile', config it here. See more `ibuffer-filter-groups'"
  :type 'sexp
  :group 'vonfry-modules)
