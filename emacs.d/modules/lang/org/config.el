;;; org config -*- lexical-binding: t -*-
;;

(defconst +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-cache-dir)
   "org clock save")

(defconst +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords")

(defconst +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   "org capture")

(load (expand-file-name "agenda/tags" vonfry-org-dir) t t)

(unless (boundp 'vonfry--org-agenda-tags-m)
  (defconst vonfry--org-agenda-tags-m
    '((":d"  "Category: dev"     tags "dev"     )
      ("@hs" "Context: haskell"  tags "@haskell"))
    "vonfry tags\nIt is a list of '(key desc tag).\nThe key start with ':' is category and start with '@' is context.\nCategory: number of ':' means the level of category.\nThe first level will be saved as a file."))

(let* ((org-dir-with    (lambda (d) (expand-file-name d vonfry-org-dir)))
       (file-with-org   (lambda (f) (concat f ".org")))
       (agenda-dir-with (lambda (f) (expand-file-name (funcall file-with-org f) (funcall org-dir-with "agenda/"))))
       (note-dir-with   (lambda (f) (expand-file-name (funcall file-with-org f) (funcall org-dir-with "note/"  ))))
       (get-key  (lambda (m) (nth 0 m)))
       (get-desc (lambda (m) (nth 1 m)))
       (get-tag  (lambda (m) (nth 2 m)))
       (is-top-level-tag
         (lambda (m)
               (let ((k (funcall get-key m)))
                 (and (string-prefix-p ":" k)
                      (not (string-prefix-p "::" k))))))
       (top-level-m (-filter is-top-level-tag vonfry--org-agenda-tags-m))
       (all-tags
         (-map get-tag vonfry--org-agenda-tags-m))
       (top-level-tags
         (-map get-tag top-level-m)))
  (defconst +org-capture-templates
    (let ((default-templates
            '(("c" "capture to inbox, refile later" entry (file+headline +org-capture-file "Tasks")
               "\n* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)
              ("i" "capture to inbox, refile later" entry (file+headline +org-capture-file "Ideals")
               "\n* %?\n:PROPERTIES:\n:CREATED: %U\n" :empty-lines 1)
              ("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1)))
          (agenda-templates
            (-map
              (lambda (m)
                (let* ((key  (funcall get-key  m))
                       (desc (funcall get-desc m))
                       (tag  (funcall get-tag  m))
                       (key-no-colon (substring key 1 (length key))))
                  `(,key-no-colon ,(concat "capture to " tag ", refile later") entry (file ,(funcall agenda-dir-with tag))
                    ,(concat "\n* TODO %?\t:" tag ":\n:PROPERTIES:\n:CREATED: %U\n:END:\n") :empty-lines 1)))
              top-level-m)))
      (append default-templates agenda-templates))
    "org capture templates")
  (defconst +org-agenda-files
    (-map agenda-dir-with top-level-tags)
    "global agenda dir")
  (defconst +org-refile-targets
    (-map
      (lambda (f)
        (-map
          (lambda (tag)
            `(,f :tag . ,tag))
            all-tags))
      +org-agenda-files))
  (defconst +org-agenda-custom-commands
    (let ((custom-tags-commands
            (-map
              (lambda (m)
                (let ((key   (funcall get-key  m))
                      (desc  (funcall get-desc m))
                      (tag   (funcall get-tag  m)))
                  `(,key ,desc tags ,tag)))
              vonfry--org-agenda-tags-m))
          (custom-commands
            '((":" . "[TAGS]Category select")
              ("@" . "[TAGS]Context  select")
              (">" . "[TODO]Keyword  select")
              (">t" tags "TODO"     )
              (">w" tags "WAITING"  )
              (">s" tags "SOMEDAY"  )
              (">d" tags "DONE"     )
              (">c" tags "CANCELLED"))))
      (append custom-tags-commands custom-commands))
  "org agenda custom commands"))

(defconst +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  "org-brain path")

