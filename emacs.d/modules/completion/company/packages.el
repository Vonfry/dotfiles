;;; company packages -*- lexical-binding: t -*-
;;

(package! company
  :custom
  (company-idle-delay 0.2)
  (company-tooltip-limit 16)
  (company-tooltip-flip-when-above t)
  :config
  (global-company-mode))

(package! company-quickhelp
  :after company
  :hook (company-mode . company-quickhelp-mode))

(package! company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq
   company-box-icons-elisp (list
                            (concat (all-the-icons-material "functions") " ")
                            (concat (all-the-icons-material "check_circle") " ")
                            (concat (all-the-icons-material "stars") " ")
                            (concat (all-the-icons-material "format_paint") " "))
   company-box-icons-unknown (concat (all-the-icons-material "find_in_page") " ")))
