;;; ibuffer config -*- lexical-binding: t -*-
;;

(defcustom +ibuffer-filter-groups
  '(("Circe" (or (mode . circe-channel-mode)
                 (mode . circe-query-mode)
                 (mode . circe-server-mode)))
    ("Mu4e" (starred-name . "*mu4e-"))
    ("Flycheck" (starred-name . "*Flycheck"))
    ("Elfeed" (starred-name . "*elfeed"))
    ("Process" (or (mode . process-menu-mode)
                   (mode . proced-mode)))
    ("Lisp" (or (mode . lisp-interaction-mode)))
    ("LSP" (starred-name . "*lsp-"))
    ("Message" (or (starred-name . "*straight")
                   (starred-name . "*Messages*")
                   (starred-name . "*direnv*")
                   (mode         . help-mode))))
  "ibuffer groups, because of `ibuffer-projectile', config it here. See more `ibuffer-filter-groups'"
  :group 'vonfry-modules)
