;;; orgmode config -*- lexical-binding: t -*-

(vonfry|use-package! org
  :init
  (defcustom +org-clock-persist-file
     (expand-file-name "org-clock-save.el" vonfry-org-dir)
     "org clock save"
     :group 'vonfry-modules)
  (defcustom +org-todo-keywords-sequence
    '((sequence "TODO(t)" "|" "DONE(d)")
            (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
    "org todo keywords"
    :group 'vonfry-modules)
  (defcustom +org-capture-file
     (expand-file-name "capture.org" vonfry-org-dir)
     "org capture"
     :group 'vonfry-modules)
  :config
  (custom-set-variables
    '(org-clock-persist t)
    '(org-default-notes-file +org-capture-file)
    '(org-todo-keywords +org-todo-keywords-sequence)
    '(org-clock-persist-file +org-clock-persist-file)
    '(org-log-done 'time))
  (org-clock-persistence-insinuate)
  ;; load babel language by ourselves when we needs them.
  (vonfry|use-package! ob-ipython)
  (vonfry|use-package! ob-http)))

(vonfry|use-package! org-bullets
  :after org
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(vonfry|use-package! evil-org
  :after evil org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'org-mode-hook
    (lambda ()
      (evil-org-set-key-theme '(navigation insert textobjects additional)))))
