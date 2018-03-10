;;; orgmode config -*- lexical-binding: t -*-

(use-package! org
  :init
  (defcustom +org-clock-persist-file
     (expand-file-name "org-clock-save.el" vonfry-local-dir)
     "org clock save"
     :group 'vonfry-modules)
  (defcustom +org-todo-keywords-sequence
    '((sequence "TODO(t)" "|" "DONE(d)" "REJECT(j)")
      (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
    "org todo keywords"
    :group 'vonfry-modules)
    (defcustom +org-capture-templates
      '(("t" "Todo" entry (file+headline +org-capture-file "Tasks")
          "* TODO %?\n  %i\n  %a"))
      "org capture templates"
      :group 'vonfry-modules)
  (defcustom +org-capture-file
     (expand-file-name "capture.org" vonfry-org-dir)
     "org capture"
     :group 'vonfry-modules)
  :config
  (custom-set-variables
   '(org-clock-persist t)
   '(org-default-notes-file +org-capture-file)
   '(org-capture-templates +org-capture-templates)
   '(org-todo-keywords +org-todo-keywords-sequence)
   '(org-clock-persist-file +org-clock-persist-file)
   '(org-log-done 'time)
   '(todo-directory vonfry-org-dir)
   '(todo-default-todo-file "todo.org")
   '(org-display-custom-times t)
   '(org-time-stamp-custom-formats '("<%Y-%m-%d %Z>" . "<%Y-%m-%d %H:%M:%S %z>")))
  (org-clock-persistence-insinuate)
  ;; load babel language by ourselves when we needs them.
  (use-package! ob-ipython)
  (use-package! ob-http))

(use-package! org-bullets
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package! evil-org
  :after evil org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'org-mode-hook
    (lambda ()
      (evil-org-set-key-theme '(navigation insert textobjects additional)))))

(use-package! org-brain
  :after org
  :init
  (defcustom +org-brains-path
    (expand-file-name "brains" vonfry-org-dir)
    "org-brain path"
    :group 'vonfry-modules)
  (custom-set-variables '(org-brain-path +org-brains-path))
  :config
  (add-hook 'org-brain-after-resource-button-functions
    (lambda (link)
      (insert (format "%s "
                (cond ((string-prefix-p "http" link)
                       (cond ((string-match "wikipedia\\.org" link)
                              (all-the-icons-faicon "wikipedia-w"))
                             ((string-match "github\\.com" link)
                              (all-the-icons-octicon "mark-github"))
                             ((string-match "vimeo\\.com" link)
                              (all-the-icons-faicon "vimeo"))
                             ((string-match "youtube\\.com" link)
                              (all-the-icons-faicon "youtube"))
                             (t
                              (all-the-icons-faicon "globe"))))
                      ((string-prefix-p "brain:" link)
                       (all-the-icons-fileicon "brain"))
                      (t
                       (all-the-icons-icon-for-file link)))))))
  (custom-set-variables
   '(org-id-track-globally t)
   '(org-id-locations-file (expand-file-name "org-id-locations" vonfry-local-dir))
   '(org-brain-visualize-default-choices 'all)
   '(org-brain-title-max-length 16))
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  (push '("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1) +org-capture-templates))
