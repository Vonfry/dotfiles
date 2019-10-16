;;; orgmode packages -*- lexical-binding: t -*-
;;

(package! org
  :custom
  (org-clock-persist t)
  (org-default-notes-file +org-capture-file)
  (org-capture-templates +org-capture-templates)
  (org-todo-keywords +org-todo-keywords-sequence)
  (org-clock-persist-file +org-clock-persist-file)
  (org-agenda-custom-commands +org-agenda-custom-commands)
  (org-log-done 'time)
  (todo-directory vonfry-org-dir)
  (todo-default-todo-file "todo.org")
  (org-display-custom-times t)
  (org-time-stamp-custom-formats '("<%Y-%m-%d %Z>" . "<%Y-%m-%d %H:%M:%S %z>"))
  :config
  (org-clock-persistence-insinuate))

(package! ob-ipython :after org)
(package! ob-http :after org)

(package! org-bullets
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(package! evil-org
  :after evil org
  :hook
  ((org-mode . evil-org-mode)
  (org-mode .
    (lambda ()
      (evil-org-set-key-theme '(navigation insert textobjects additional))))))

(package! org-brain
  :after org
  :custom
  (org-brain-path +org-brains-path)
  (org-id-track-globally t)
  (org-id-locations-file (expand-file-name "org-id-locations" vonfry-cache-dir))
  (org-brain-visualize-default-choices 'all)
  (org-brain-title-max-length 16)
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  (push '("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1) +org-capture-templates))

(package! org-agenda
  :ensure nil
  :after org
  :custom
  (org-agenda-files +org-agenda-files))

(require 'org-archive)
