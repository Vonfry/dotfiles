;;; web packages -*- lexical-binding: t -*-

(package! web-mode
  :config
  (setq web-mode-markup-indent-offset 4
        web-mode-css-indent-offset 4
        web-mode-code-indent-offset 4
        web-mode-engines-alist '(("php"    . "\\.phtml\\'")
                                 ("php"    . "\\.php\\'")
                                 ("blade"  . "\\.blade\\."))
        web-mode-content-types-alist '(("json" . "/some/path/.*\\.api\\'")
                                       ("xml"  . "/other/path/.*\\.api\\'")
                                       ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))
  :mode
  (("\\.phtml\\'"      . web-mode)
   ("\\.tpl\\.php\\'"  . web-mode)
   ("\\.php\\'"        . web-mode)
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
   ("\\.css\\'"        . css-mode))
  :hook
  (web-mode .
    (lambda ()
      (rainbow-mode t)
      (nmap :keymaps 'local
            :prefix +lang-nmap-prefix
            ";" 'web-mode-tag-select))))

(package! haml-mode :after web-mode)

(package! emmet-mode
  :after web-mode
  :hook
  (web-mode . emmet-mode))
