(require-package 'auctex)
(defun vonfry/setup-latex-mode ()
  (setq
    TeX-command-default latex-build-command
    TeX-auto-save t
    TeX-parse-self t
    TeX-syntactic-comment t
    ;; Synctex support
    TeX-source-correlate-start-server nil
    ;; Don't insert line-break at inline math
    LaTeX-fill-break-at-separators nil
    auctex-latexmk-inherit-TeX-PDF-mode t)

  (add-hook 'evil-leader/set-key
    (lambda ()
      (dolist (mode '(tex-mode latex-mode))
        (evil-leader/set-key-for-mode  mode
          "\\"  'TeX-insert-macro                            ;; C-c C-m
          "-"   'TeX-recenter-output-buffer                  ;; C-c C-l
          "%"   'TeX-comment-or-uncomment-paragraph          ;; C-c %
          ";"   'TeX-comment-or-uncomment-region             ;; C-c ; or C-c :
          ;; TeX-command-run-all runs compile and open the viewer
          "a"   'TeX-command-run-all                         ;; C-c C-a
          "b"   'latex/build
          "k"   'TeX-kill-job                                ;; C-c C-k
          "l"   'TeX-recenter-output-buffer                  ;; C-c C-l
          "m"   'TeX-insert-macro                            ;; C-c C-m
          "v"   'TeX-view                                    ;; C-c C-v
          ;; TeX-doc is a very slow function
          "hd"  'TeX-doc
          "xb"  'latex/font-bold
          "xc"  'latex/font-code
          "xe"  'latex/font-emphasis
          "xi"  'latex/font-italic
          "xr"  'latex/font-clear
          "xo"  'latex/font-oblique
          "xfc" 'latex/font-small-caps
          "xff" 'latex/font-sans-serif
          "xfr" 'latex/font-serif)
        (when latex-enable-folding
          (evil-leader/set-key-for-mode mode
            "z=" 'TeX-fold-math
            "zb" 'TeX-fold-buffer
            "ze" 'TeX-fold-env
            "zm" 'TeX-fold-macro
            "zr" 'TeX-fold-region))
        (evil-leader/set-key-for-mode mode "mh" "help")
        (evil-leader/set-key-for-mode mode "mx" "text/fonts")
        (evil-leader/set-key-for-mode mode "mz" "fold"))

      ;; Key bindings specific to LaTeX
      (evil-leader/set-key-for-mode 'latex-mode
        "*"   'LaTeX-mark-section      ;; C-c *
        "."   'LaTeX-mark-environment  ;; C-c .
        "c"   'LaTeX-close-environment ;; C-c ]
        "e"   'LaTeX-environment       ;; C-c C-e
        "ii"   'LaTeX-insert-item       ;; C-c C-j
        "s"   'LaTeX-section           ;; C-c C-s
        "fe"  'LaTeX-fill-environment  ;; C-c C-q C-e
        "fp"  'LaTeX-fill-paragraph    ;; C-c C-q C-p
        "fr"  'LaTeX-fill-region       ;; C-c C-q C-r
        "fs"  'LaTeX-fill-section      ;; C-c C-q C-s
        "pb"  'preview-buffer
        "pc"  'preview-clearout
        "pd"  'preview-document
        "pe"  'preview-environment
        "pf"  'preview-cache-preamble
        "pp"  'preview-at-point
        "pr"  'preview-region
        "ps"  'preview-section
        "xB"  'latex/font-medium
        "xr"  'latex/font-clear
        "xfa" 'latex/font-calligraphic
        "xfn" 'latex/font-normal
        "xfu" 'latex/font-upright)
      (evil-leader/set-key-for-mode 'latex-mode "mi" "insert")
      (evil-leader/set-key-for-mode 'latex-mode "mp" "preview")
      (evil-leader/set-key-for-mode 'latex-mode "mf" "fill")))
  (with-eval-after-load 'company
    (progn
      (push 'company-auctex-labels company-backends-LaTeX-mode)
      (push 'company-auctex-bibs company-backends-LaTeX-mode)
      (push '(company-auctex-macros
              company-auctex-symbols
              company-auctex-environments) company-backends-LaTeX-mode))))

(add-hook 'LaTeX-mode-hook 'vonfry/setup-latex-mode)
(add-hook 'tex-mode-hook 'vonfry/setup-latex-mode)

(provide 'init-latex)
