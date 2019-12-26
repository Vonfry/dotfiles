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
  (org-refile-targets +org-refile-targets)
  (org-tag-alist +org-tag-alist)
  :general
  ("C-c C" 'org-capture-goto-target)
  ("C-c a" 'org-agenda))

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
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs)))

(package! org-agenda
  :straight nil
  :after org
  :custom
  (org-agenda-files +org-agenda-files)
  :general
  (+mmap-todo-def
    "a" 'org-agenda
    "A" '+org/find-agenda
    "n" '+org/find-notes
    "d" '+org/find-diary
    "b" '+org/append-to-agenda-file
    "B" 'append-to-buffer
    "c" 'counsel-org-capture))

(require 'org-archive)

(package! org-super-agenda
  :after org
  :hook (org-agenda-mode . org-super-agenda-mode)
  :custom
  (org-super-agenda-groups +org-super-agenda-groups))
