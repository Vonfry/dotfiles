;;; ligature modules -*- lexical-binding: t; -*-
;;

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode
                          '("==" "===" "!!" "??" "%%" "&&" "||" "=>" "->" "<-"
                            "##" "###" "####" "//" ">=" "<=" "f\"" "${"
                            "!=" "!==" "=/=" "?." "?:" "&&&"))
  (global-ligature-mode t))
