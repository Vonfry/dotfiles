;;; org config -*- lexical-binding: t -*-
;;

(vonfry-def-mmap-mode-prefix org nil
  :keymaps 'org-mode-map)

(custom! +org-journal-dir
  (expand-file-name "diary" vonfry-org-dir)
  ""
  :type 'directory
  :group 'vonfry-modules
  :custom-set 'org-journal-dir)

(defun +org--journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(load (expand-file-name "tags.el" +org-journal-dir) t t)
(custom! +org-journal-tag-alist nil
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-journal-tag-alist)

(custom! +org-note-dir (expand-file-name "notes" vonfry-org-dir)
  "org note dir."
  :type 'directory
  :group 'vonfry-modules)

(custom! +org-note-templates-get-location-function
  (lambda (&rest args)
    (interactive)
    (let* ((path (read-file-name "note file: " +org-note-dir)))
           (set-buffer (org-capture-target-buffer path))
           (widen)
           (org-capture-put-target-region-and-position)
           (goto-char (point-max))))
  "location for org diary by org-capture under `+org-diary-dir'."
  :type 'function
  :group 'vonfry-modules)

(fun! +org--note-templates-get-location (&rest args)
  (funcall +org-diary-templates-get-location-function args)
  "call `+org-note-templates-get-location-function'")

(custom! +org-todo-keywords-sequence
  '((sequence "TODO(t)" "WAITING(w)" "SOMEDAY(s)" "|" "DONE(d)" "CANCELLED(c)")
    (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)"))
  ""
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-todo-keywords)

(custom! +org-capture-file
   (expand-file-name "inbox.org" vonfry-org-dir)
   ""
   :type 'file
   :group 'vonfry-modules
   :custom-set 'org-capture-file)

(load (expand-file-name "agenda/tags" vonfry-org-dir) t t)

(custom! +org--tags-gtd-sym "#" "org tags symbol" :type 'string :group 'vonfry-modules)
(custom! +org--tags-cat-sym ":" "org tags symbol" :type 'string :group 'vonfry-modules)
(custom! +org--tags-ctx-sym "@" "org tags symbol" :type 'string :group 'vonfry-modules)
(custom! +org--tags-m
  `((("gtd" ,+org--tags-gtd-sym)
     ((("category" ,+org--tags-cat-sym)
       ((("dev" "d"))))
      (("context"  ,+org--tags-ctx-sym)
       ((("haskell" "hs")))))))
   "vonfry org agenda tags, which is used in org-agenda-custom-commands. The data struct see `+org-tag-alist'"
  :type 'sexp
  :group 'vonfry-modules)

(fun! +org--unzip-org-agenda-tags-m (m &optional l prefix prefix-level prefix-tag)
  "expend '+org--tags-m' from a hierarchy to a non-hierarchy list.\nThe second optional arguments are used to recurrence.\n"
  (-let (((m l is-top prefix-level)
            (if (not (or l prefix prefix-level))
              (-let* ((gtd (nth 0 m))
                      ((gtd-tag gtd-subtag) gtd)
                      ((gtd-name gtd-sym) gtd-tag)
                      ((cat-tag cat-subtag) (nth 0 gtd-subtag))
                      ((cat-name cat-sym) cat-tag)
                      ((ctx-tag ctx-subtag) (nth 1 gtd-subtag))
                      ((ctx-name ctx-sym) ctx-tag))
                `((,cat-subtag ,ctx-subtag)
                  ((,(concat gtd-sym gtd-name) ,gtd-sym)
                   (,(concat cat-sym cat-name) ,cat-sym)
                   (,(concat ctx-sym ctx-name) ,ctx-sym))
                  t
                  0))
              `(,m ,l nil ,prefix-level))))
    (if is-top
      (-let* (((cat-subtag ctx-subtag) m)
              (cat-m (+org--unzip-org-agenda-tags-m cat-subtag nil +org--tags-cat-sym 1 nil))
              (ctx-m (+org--unzip-org-agenda-tags-m ctx-subtag nil +org--tags-ctx-sym 1 nil)))
        (append l cat-m ctx-m))
      (-reduce-r-from
        (lambda (i c)
          (let ((l (let* ((tag (nth 0 i))
                          (tag-name
                            (if (string= prefix +org--tags-ctx-sym)
                              (concat prefix (nth 0 tag))
                              (nth 0 tag)))
                          (tag-abbr (nth 1 tag))
                          (abbr-prefix (s-repeat prefix-level prefix))
                          (tag-names (if prefix-tag
                                         (concat prefix-tag prefix tag-name)
                                         tag-name))
                          (l (cons (list tag-names (concat abbr-prefix tag-abbr)) l)))
                      (if (> (length i) 1)
                        (+org--unzip-org-agenda-tags-m (nth 1 i) l prefix (1+ prefix-level) tag-names)
                        l))))
            (append l c)))
        nil
        m))))

(fun! +org--tag-alist-generate (m &optional prefix level)
  "generate 'org-tag-alist' from '+org--tags-m'"
  (-let ((prefix (if (not level) +org--tags-gtd-sym prefix))
         (level (if level level 0)))
    (-reduce-r-from
      (lambda (i c)
        (-let* ((tag (car i))
                ((tag-name tag-abbr) tag)
                (tag-name (concat prefix tag-name)))
          (if (= 1 (length i))
            (cons `(,tag-name) c)
            (let* ((prefix
                    (cond ((and (= 1 level)
                                (string= tag-abbr +org--tags-ctx-sym))
                            tag-abbr)
                          ((> 1 level) prefix)
                          (t nil)))
                   (l `((:startgrouptag)
                        (,tag-name)
                        (:grouptags)
                        ,@(+org--tag-alist-generate (nth 1 i) prefix (1+ level))
                        (:endgrouptag))))
               (append l c)))))
      nil
      m)))

(custom! +org-tag-alist
  (+org--tag-alist-generate +org--tags-m)
  "org tag alist. It is generated from '+org--tags-m', which struct is defined as following:\n\n\tvonfry tags\n\tIt is a list.\n\ttag := (list tag abbr)\n\tsubtag := (list tag tag ...)\n\t taglist := (list tag subtag)\n\n\n\tEach list's first element is the tag name and second is its subtag. A subtag is same as a tag list.\n\tEach tag is a list, first element is the whole name, and second is a abbr name.\n\tThe key start with '#' are the kinds used in gtd.The key start with ':' is category and start with '@' is context.\n\tCategory: number of ':' means the level of category.\n\tFiles are organized by workspace such as person and company. They will be set automatically by the filename under 'vonfry-org-dir'/agenda.\n\tYou can see an example in '+org--tags-m'."
  :type 'sexp
  :group 'vonfry-modules
  :custom-set 'org-tag-alist)

(let* ((org-dir-with    (lambda (d) (expand-file-name d vonfry-org-dir)))
       (file-with-org   (lambda (f) (concat f ".org")))
       (agenda-dir      (funcall org-dir-with "agenda/"))
       (agenda-dir-with (lambda (f) (expand-file-name (funcall file-with-org f) agenda-dir)))
       (agenda-files    (directory-files agenda-dir t "^.*\\.org$"))
       (note-dir        (funcall org-dir-with "notes/"))
       (note-files      (directory-files note-dir   t "^.*\\.org$"))
       (note-dir-with   (lambda (f) (expand-file-name (funcall file-with-org f) note-dir)))
       (unzip-tags-m (+org--unzip-org-agenda-tags-m +org--tags-m))
       (gtd-prefix (nth 1 (nth 0 unzip-tags-m)))
       (cat-prefix (nth 1 (nth 1 unzip-tags-m)))
       (ctx-prefix (nth 1 (nth 2 unzip-tags-m)))
       (tag-name     (lambda (names) (-last-item (split-string names cat-prefix))))
       (tag-level    (lambda (names) (if (string-prefix-p ctx-prefix names)
                                         77
                                         (length (split-string names cat-prefix)))))
       (unzip-tags-m-filtered
         (-filter (-lambda ((_ tagabbr))
                    (not (or (string= tagabbr gtd-prefix)
                             (string= tagabbr cat-prefix)
                             (string= tagabbr ctx-prefix))))
                  unzip-tags-m))
       (get-key   (lambda (um) (nth 1 um)))
       (get-tag   (lambda (um) (nth 0 um)))
       (get-desc  (-lambda ((tag key))
                    (cond ((string-prefix-p cat-prefix key) (concat "[TAGS:Category] " tag))
                          ((string-prefix-p ctx-prefix key) (concat "[TAGS:Context] "  tag)))))
       (all-tags
         (-map (lambda (tag) (funcall tag-name (funcall get-tag tag))) unzip-tags-m)))
  (custom! +org-agenda-dir agenda-dir
    ""
    :type 'directory
    :group 'vonfry-modules)
  (custom! +org-agenda-files agenda-files
    ""
    :type '(repeat file)
    :group 'vonfry-modules
    :custom-set 'org-agenda-files)
  (custom! +org-capture-templates
    (let ((default-templates
            '(("c" "capture to inbox(Tasks), refile later" entry (file+headline +org-capture-file "Tasks")
               "* TODO %?\n:PROPERTIES:\n:CREATED: %U\n:END:n" :empty-lines 1)
              ("i" "capture to inbox(Idea), refile later" entry (file+headline +org-capture-file "Idea")
               "* %?\n:PROPERTIES:\n:CREATED: %Un" :empty-lines 1)
              ("n" "capture to note" plain (function +org--note-templates-get-location)
               "#+TITLE: %^{title}\n#+DATE: %U\n* Context %^{tags}\n\n* Main Text\n\n%?" :empty-lines 1)
              ("j" "Journal entry" entry (function +org--journal-find-location)
                               "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
              ("b" "Brain" plain (function org-brain-goto-end) "* %i%?" :empty-lines 1)
              ("a" "capture to agenda")))
          (agenda-templates
            (-map-indexed
              (lambda (index file-path)
                (let* ((file-name (file-name-nondirectory file-path))
                       (keys (concat "a" (string (+ ?A index)))))
                  `(,keys ,(concat "capture to " file-name ", refile later") entry (file ,file-path)
                    "* TODO %?\t\n:PROPERTIES:\n:CREATED: %U\n:END:" :empty-lines 1)))
              agenda-files)))
      (append default-templates agenda-templates))
    ""
    :type 'sexp
    :group 'vonfry-modules
    :custom-set 'org-capture-templates)
  (custom! +org-refile-targets nil
    ""
    :type 'sexp
    :group 'vonfry-modules
    :custom-set 'org-refile-targets)
  (custom! +org-agenda-custom-commands
    (let ((custom-tags-commands
            (-map
              (-lambda ((tag key))
                  `(,key ,(funcall get-desc `(,tag ,key)) tags ,tag))
              unzip-tags-m-filtered))
          (custom-commands
            `((,cat-prefix . "[TAGS]Category select")
              (,ctx-prefix . "[TAGS]Context  select")
              (,gtd-prefix . "[TAGS]All GTD")
              (">" . "[TODO]Keyword  select")
              (">t" tags "TODO"     )
              (">w" tags "WAITING"  )
              (">s" tags "SOMEDAY"  )
              (">d" tags "DONE"     )
              (">c" tags "CANCELLED"))))
      (append custom-tags-commands custom-commands))
    ""
    :type '(choice (const :tag "Disabled" nil)
                   (character)
                   (string))
    :group 'vonfry-modules
    :custom-set 'org-agenda-custom-commands))

(custom! +org-brains-path
  (expand-file-name "brains" vonfry-org-dir)
  ""
  :type 'directory
  :group 'vonfry-modules
  :custom-set 'org-brains-path)
