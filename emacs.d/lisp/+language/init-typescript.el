(require-package 'typescript-mode)
(require-package 'tide)
(defun vonfry/setup-typescript-mode ()
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'typescript-mode
              "gb" 'tide-jump-back
              "gt" 'typescript/jump-to-type-def
              "gu" 'tide-references
              "hh" 'tide-documentation-at-point
              "rr" 'tide-rename-symbol
              "Sr" 'tide-restart-server
              "="  'typescript/format
              "sp" 'typescript/open-region-in-playground)))
  (add-hook 'web-mode-hook
    (lambda ()
      (when (and (buffer-file-name)
                 (string-equal "tsx" (file-name-extension (buffer-file-name))))
        (tide-setup)
        (flycheck-mode +1)
        (eldoc-mode +1)
        (when (configuration-layer/package-usedp 'company)
          (company-mode-on)))))
  (ycmd-mode)
  (ggtags-mode 1))
(add-hook 'typescript-mode-hook 'vonfry/setup-typescript-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))

(provide 'init-typescript)
