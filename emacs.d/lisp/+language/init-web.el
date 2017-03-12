(require-package 'web-mode)
(require-package 'emmet-mode)
(require-package 'haml-mode)
(require-package 'less-css-mode)
(require-package 'pug-mode)
(require-package 'sass-mode)
(require-package 'scss-mode)

(defun vonfry/setup-web-mode ()
  (with-eval-after-load 'company
    (progn
      (push '(company-web-html company-css) company-backends-web-mode)
      (push 'company-css company-backends-css-mode)))
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'web-mode
      "eh" 'web-mode-dom-errors-show
      "gb" 'web-mode-element-beginning
      "gc" 'web-mode-element-child
      "gp" 'web-mode-element-parent
      "gs" 'web-mode-element-sibling-next
      "hp" 'web-mode-dom-xpath
      "rc" 'web-mode-element-clone
      "rd" 'web-mode-element-vanish
      "rk" 'web-mode-element-kill
      "rr" 'web-mode-element-rename
      "rw" 'web-mode-element-wrap
      "z" 'web-mode-fold-or-unfold)))
  (setq web-mode-engines-alist
        '(("php"    . "\\.phtml\\'")
          ("blade"  . "\\.blade\\.")))
  (setq web-mode-content-types-alist
    '(("json" . "/some/path/.*\\.api\\'")
      ("xml"  . "/other/path/.*\\.api\\'")
      ("jsx"  . "/some/react/path/.*\\.js[x]?\\'")))
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (require 'emmet-mode)
  (local-set-key (kbd "C-j") 'emmet-expand-line)
  (emmet-mode)
  (require 'haml-mode))

(add-hook 'web-mode-mode-hook      'vonfry/setup-html-mode)
(add-hook 'css-mode-hook           'vonfry/setup-html-mode)
(add-hook 'sass-mode-mode-hook     'vonfry/setup-html-mode)
(add-hook 'scss-mode-mode-hook     'vonfry/setup-html-mode)
(add-hook 'less-css-mode-mode-hook 'vonfry/setup-html-mode)
(add-hook 'pug-mode-mode-hook      'vonfry/setup-html-mode)
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
                 ("\\.css\\'"        . css-mode)
                 ("\\.pug$"          . pug-mode)
                 ("\\.scss\\'"       . scss-mode)
                 ("\\.less\\'"       . less-css-mode)
                 ("\\.sass\\'"       . sass-mode)))
    (add-to-list 'auto-mode-alist alist))

(provide 'init-web)
