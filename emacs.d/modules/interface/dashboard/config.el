;;; dashboard config -*- lexical-binding: t -*-
;;

(custom! +dashboard-banner (if (file-exists-p "~/.config/bg.png") "~/.config/bg.png" 'logo)
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'dashboard-startup-banner)
