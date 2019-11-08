;;; org config -*- lexical-binding: t -*-
;;

(defcustom +org-clock-persist-file
   (expand-file-name "org-clock-save.el" vonfry-cache-dir)
   "org clock save"
   :type 'file
   :group 'vonfry-modules)

(defcustom +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  "org todo keywords"
  :group 'vonfry-modules)

(defcustom +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   "org capture"
   :type 'file
   :group 'vonfry-modules)

(defcustom +org-agenda-tags-file
   (expand-file-name "agenda/tags" vonfry-org-dir)
   "Custom tag file to read config of tags.\nIts structor is like dir-locals.\n\n'((tag subtag))'\nHere 'subtag' can be another list with '(tag subtag)'."
   :type 'file
   :group 'vonfry-modules)

(load +org-agenda-tags-file t t)

(unless (boundp 'vonfry--org-agenda-tags-m)
  (defcustom vonfry--org-agenda-tags-m
    '((("gtd" "#")
      ((("category" ":")
         ((("dev" "d"))))
       (("context"  "@")
         ((("haskell" "hs")))))))
    "vonfry tags\nIt is a list of '(((tag abbr) (subtags) (subtags) ...)).\nEach list's first element is the tag name and second is its subtag. A subtag is same as a tag list. Each tag is a list, first element is the whole name, and second is a abbr name.\nThe key start with ':' is category and start with '@' is context.\nCategory: number of ':' means the level of category.\nFiles are organized by workspace such as person and company. They will be set automatically by the filename under 'vonfry-org-dir'/agenda."
    :group 'vonfry-modules))

(defun vonfry--unzip-org-agenda-tags-m (m &optional l prefix prefix-level)
  "expend 'vonfry--org-agenda-tags-m' from a hierarchy to a non-hierarchy list.\nThe second optional arguments are used to recurrence."
  (-let (((m l is-top prefix-level cat-tag-sym ctx-tag-sym)
            (if (not (or l prefix prefix-level))
              (-let* ((gtd (nth 0 m))
                      ((gtd-tag gtd-subtag) gtd)
                      ((cat-tag cat-subtag) (nth 0 gtd-subtag))
                      ((ctx-tag ctx-subtag) (nth 1 gtd-subtag)))
                `((,cat-subtag ,ctx-subtag)
                  (,gtd-tag ,cat-tag ,ctx-tag)
                  t
                  0
                  ,(nth 1 cat-tag)
                  ,(nth 1 ctx-tag)))
              `(,m ,l nil ,prefix-level nil nil))))
    (if is-top
      (-let* (((cat-subtag ctx-subtag) m)
              (cat-m (vonfry--unzip-org-agenda-tags-m cat-subtag nil cat-tag-sym 1))
              (ctx-m (vonfry--unzip-org-agenda-tags-m ctx-subtag nil ctx-tag-sym 1)))
        (append l cat-m ctx-m))
      (-reduce-r-from
        (lambda (i c)
          (let ((l (let* ((tag (nth 0 i))
                          (tag-name (nth 0 tag))
                          (tag-abbr (nth 1 tag))
                          (tag-prefix (-reduce-from 'concat "" (-repeat prefix-level prefix)))
                          (l (cons (list tag-name (concat tag-prefix tag-abbr)) l)))
                      (if (> (length i) 1)
                        (vonfry--unzip-org-agenda-tags-m (cdr i) l prefix (1+ prefix-level))
                        l))))
            (append l c)))
        nil
        m))))

(let* ((org-dir-with    (lambda (d) (expand-file-name d vonfry-org-dir)))
       (file-with-org   (lambda (f) (concat f ".org")))
       (agenda-dir      (funcall org-dir-with "agenda/"))
       (agenda-dir-with (lambda (f) (expand-file-name (funcall file-with-org f) agenda-dir)))
       (agenda-files    (directory-files agenda-dir t "^.*\\.org$"))
       (note-dir        (funcall org-dir-with "notes/"))
       (note-files      (directory-files note-dir   t "^.*\\.org$"))
       (note-dir-with   (lambda (f) (expand-file-name (funcall file-with-org f) note-dir)))
       (unzip-tags-m (vonfry--unzip-org-agenda-tags-m vonfry--org-agenda-tags-m))
       (gtd-prefix (nth 0 (nth 0 unzip-tags-m)))
       (cat-prefix (nth 1 (nth 1 unzip-tags-m)))
       (ctx-prefix (nth 1 (nth 2 unzip-tags-m)))
       (unzip-tags-m-filtered
         (-filter (-lambda ((_tag tagabbr))
                    (not (or (string= tagabbr cat-prefix)
                             (string= tagabbr ctx-prefix))))
                  unzip-tags-m))
       (get-key   (lambda (um) (nth 1 um)))
       (get-tag   (lambda (um) (nth 0 um)))
       (get-desc  (lambda (tag)
                    (cond ((string-prefix-p cat-prefix tag) (concat "[TAGS:Category] " tag))
                          ((string-prefix-p ctx-prefix tag) (concat "[TAGS:Context] "  tag)))))
       (all-tags
         (-map get-tag unzip-tags-m)))
  (defcustom +org-agenda-files agenda-files
    "global agenda dir"
    :group 'vonfry-modules)
  (defcustom +org-capture-templates
    (let ((default-templates
            '(("c" "capture to inbox, refile later" entry (file+headline +org-capture-file "Tasks")
               "\n* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)
              ("i" "capture to inbox, refile later" entry (file+headline +org-capture-file "Ideals")
               "\n* %?\n:PROPERTIES:\n:CREATED: %U\n" :empty-lines 1)
              ("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1)))
          (agenda-templates
            (-map
              (lambda (file-path)
                (let* ((file-name (file-name-nondirectory file-path))
                       (file-firstchar (substring file-name 0 1)))
                  `(,file-firstchar ,(concat "capture to " file-name ", refile later") entry (file ,file-path)
                    "\n* TODO %?\t\n:PROPERTIES:\n:CREATED: %U\n:END:\n" :empty-lines 1)))
              agenda-files)))
      (append default-templates agenda-templates))
    "org capture templates"
    :group 'vonfry-modules)
  (defcustom +org-refile-targets
    (-map
      (lambda (f)
        (-map
          (lambda (tag)
            `(,f :tag . ,tag))
            all-tags))
      +org-agenda-files)
    "org refile targets"
    :group 'vonfry-modules)
  (defcustom +org-agenda-custom-commands
    (let ((custom-tags-commands
            (-map
              (-lambda ((tag key))
                  `(,key ,(funcall get-desc tag) tags ,tag))
              unzip-tags-m-filtered))
          (custom-commands
            '((cat-prefix . "[TAGS]Category select")
              (ctx-prefix . "[TAGS]Context  select")
              (gtd-prefix . "[TAGS]All GTD")
              (">" . "[TODO]Keyword  select")
              (">t" tags "TODO"     )
              (">w" tags "WAITING"  )
              (">s" tags "SOMEDAY"  )
              (">d" tags "DONE"     )
              (">c" tags "CANCELLED"))))
      (append custom-tags-commands custom-commands))
  "org agenda custom commands"
  :group 'vonfry-modules))

(defcustom +org-brains-path
  (expand-file-name "brains/" vonfry-org-dir)
  "org-brain path"
  :type 'directory
  :group 'vonfry-modules)

