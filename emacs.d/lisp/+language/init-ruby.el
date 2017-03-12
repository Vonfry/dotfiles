(require-package 'bundler)
(require-package 'enh-ruby-mode)
(require-package 'inf-ruby)
(require-package 'ruby-tools)
(require-package 'company-inf-ruby)
(require-package 'helm-bundle-show)
(require-package 'rake)
(require-package 'robe)

(defun vonfry/setup-ruby-mode ()
  (require 'rake)
  (require 'bundler)
  (setq rake-cache-file (concat temporary-file-directory "rake.cache"))
  (add-hook 'evil-local-mode-hook
    (lambda ()
      (evil-leader/set-key-for-mode 'ruby-mode
        "."  'robe-jump
        "'"  'inf-ruby
        "kk" 'rake
        "kr" 'rake-rerun
        "kR" 'rake-regenerate-cache
        "kf" 'rake-find-task
        "bc" 'bundle-check
        "bi" 'bundle-install
        "bs" 'bundle-console
        "bu" 'bundle-update
        "bx" 'bundle-exec
        "bo" 'bundle-open)))
    (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
    (add-hook 'ruby-mode-hook 'enh-ruby-mode-hook)
    (add-hook 'ruby-mode-hook 'ruby-tools-mode)
    (robe-mode t)
    (with-eval-after-load 'company
      (lambda ()
        (push 'company-robe company-backends)
        (add-to-list 'company-backends 'company-inf-ruby)))
    (setq enh-ruby-deep-indent-paren nil
      enh-ruby-hanging-paren-deep-indent-level 4)
    (ggtags-mode 1))
(add-hook 'ruby-mode-hook 'vonfry/setup-ruby-mode)
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.cap\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.podspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Puppetfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Appraisals\\'" . ruby-mode))
(add-to-list 'completion-ignored-extensions ".rbc")

(provide 'init-ruby)
