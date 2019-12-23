;;; ibuffer config -*- lexical-binding: t -*-
;;

(defcustom +ibuffer-filter-groups
  '(("Circe" (or (mode . circe-channel-mode)
                 (mode . circe-query-mode)
                 (mode . circe-server-mode))))
  "ibuffer groups, because of `ibuffer-projectile', config it here. See more `ibuffer-filter-groups'"
  :group 'vonfry-modules)
