(require-package 'company)
(require-package 'company-quickhelp)
(add-to-list 'completion-styles 'initials t)

(setq company-idle-delay 0.2)
(setq company-tooltip-limit 16)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)

(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (diminish 'company-mode "CMP")
  (define-key company-mode-map (kbd "M-n") 'company-complete))
(global-set-key (kbd "M-C-/") 'company-complete)

(add-hook 'after-init-hook 'company-quickhelp-mode)

(require-package 'yasnippet)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(with-eval-after-load 'company
  (push '(company-semantic :with company-yasnippet) company-backends))
(global-set-key (kbd "C-c y") 'company-yasnippet)

(require-package 'ycmd)
(require 'ycmd)
(set-variable 'ycmd-server-command `("python3" ,(expand-file-name "~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd")))
(set-variable 'ycmd-global-config (expand-file-name "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
;;; start ycmd in languages configure file.
(require-package 'company-ycmd)
(require 'company-ycmd)
(company-ycmd-setup)
(add-hook 'ycmd-mode-hook
  (lambda ()
    (add-hook 'evil-local-mode-hook
      (lambda () (evil-leader/set-key
        "."  'ycmd-goto)))))

(provide 'init-company)
