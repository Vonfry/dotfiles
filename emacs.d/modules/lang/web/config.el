;;; web config -*- lexical-binding: t -*-

(use-package! web-mode
  :config
  (setq web-mode-markup-indent-offset 4
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4
        web-mode-engines-alist '(("php"    . "\\.phtml\\'")
                                 ("blade"  . "\\.blade\\."))
        web-mode-content-types-alist '(("json" . "/some/path/.*\\.api\\'")
                                       ("xml"  . "/other/path/.*\\.api\\'")
                                       ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))
  (dolist (alist '(("\\.phtml\\'"      . web-mode)
                   ("\\.tpl\\.php\\'"  . web-mode)
                   ("\\.twig\\'"       . web-mode)
                   ("\\.html\\'"       . web-mode)
                   ("\\.htm\\'"        . web-mode)
                   ("\\.[gj]sp\\'"     . web-mode)
                   ("\\.as[cp]x?\\'"   . web-mode)
                   ("\\.eex\\'"        . web-mode)
                   ("\\.erb\\'"        . web-mode)
                   ("\\.mustache\\'"   . web-mode)
                   ("\\.handlebars\\'" . web-mode)
                   ("\\.hbs\\'"        . web-mode)
                   ("\\.eco\\'"        . web-mode)
                   ("\\.ejs\\'"        . web-mode)
                   ("\\.djhtml\\'"     . web-mode)
                   ("\\.css\\'"        . css-mode)))
    (add-to-list 'auto-mode-alist alist))
  (add-hook 'web-mode-hook
    (lambda ()
      (rainbow-mode t)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            ";" 'web-mode-tag-select))))

(use-package! haml-mode :after web-mode)

(use-package! emmet-mode
  :after web-mode
  :init
  (add-hook 'web-mode-hook 'emmet-mode))
