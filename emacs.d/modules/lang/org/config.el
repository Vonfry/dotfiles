;;; org config -*- lexical-binding: t -*-
;;

(defconst +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-cache-dir)
   "org clock save")

(defconst +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords")

(defconst +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   "org capture")

(defconst +org-capture-templates
  '(("c" "capture to inbox, refile later" entry (file+headline +org-capture-file "Tasks")
     "\n* %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1))
  "org capture templates")

(defconst +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path")

(let ((agenda-dir-with (lambda (p) (expand-file-name p (expand-file-name "agenda/" vonfry-org-dir)))))
  (defconst +org-agenda-files
    (list +org-capture-file
          (agenda-dir-with "gtd.org")
          (agenda-dir-with "someday.org"))
    "global agenda dir")
    (defconst +org-refile-targets
      '(((agenda-dir-with "gtd.org") :maxlevel . 3)
        ((agenda-dir-with "someday.org") :level . 1)))
)

(defconst +org-agenda-custom-commands
  '((":d" "Categoriy: dev" tags-todo "dev"
     ((org-agenda-overriding-header "Dev")))
    ("@hs" "Context: haskell" tags-todo "@haskell"
         ((org-agenda-overriding-header "Haskell")))))

