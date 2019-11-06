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
     "\n** TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n" :empty-lines 1)
    ("i" "capture to inbox, refile later" entry (file+headline +org-capture-file "Ideals")
     "\n** %?\n:PROPERTIES:\n:CREATED: %U\n\n" :empty-lines 1)
    ("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1))
  "org capture templates")

(defconst +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path")

(let* ((agenda-dir-with (lambda (p) (expand-file-name p (expand-file-name "agenda/" vonfry-org-dir))))
       (gtd-file (funcall agenda-dir-with "gtd.org"))
       (someday-file (funcall agenda-dir-with "someday.org")))
  (defconst +org-agenda-files
    (list +org-capture-file
          gtd-file
          someday-file)
    "global agenda dir")
    (defconst +org-refile-targets
      '((gtd-file :maxlevel . 3)
        (someday-file :level . 1))))

(load (expand-file-name "agenda/custom" vonfry-org-dir) t t)
(defconst +org-agenda-custom-commands
  (if (boundp 'vonfry--org-agenda-custom-tags)
    (map
      (lambda (m)
        (let ((key   (-elem-index 0 m))
              (desc  (-elem-index 1 m))
              (tag   (-elem-index 2 m)))
          `(,key ,desc tags-todo ,tag)
        ))
      vonfry--org-agenda-custom-tags)
    vonfry--org-agenda-custom-tags
    '((":d"  "Categoriy: dev"    tags-todo "dev")
      ("@hs" "Context: haskell"  tags-todo "@haskell")))
  "org agenda custom commands")

