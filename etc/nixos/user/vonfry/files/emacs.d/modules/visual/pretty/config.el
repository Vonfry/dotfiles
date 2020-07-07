;;; pretty config -*- lexical-binding: t -*-
;; A copy from doom-emacs
;; https://github.com/hlissner/doom-emacs/blob/develop/modules/ui/pretty-code/config.el
;;

(custom! +pretty-code-symbols-alist '((t))
  "An alist containing a mapping of major modes to its value for
`prettify-symbols-alist'."
  :type 'sexp
  :group 'vonfry-modules)

(custom! +pretty-code-symbols
  '(;; Functional
    ("lambda"        . ?λ)
    ("def"           . ?ƒ)
    ("fun"           . ?ƒ)
    ("function"      . ?ƒ)
    ("composition"   . ?∘)
    ;; Types
    ("null"          . ?∅)
    ("None"          . ?∅)
    ("true"          . ?𝕋)
    ("True"          . ?𝕋)
    ("false"         . ?𝔽)
    ("False"         . ?𝔽)
    ("int"           . ?ℤ)
    ("float"         . ?ℝ)
    ("str"           . ?𝕊)
    ("bool"          . ?𝔹)
    ("Bool"          . ?𝔹)
    ("nat"           . 8469)
    ("Real"          . 8477)
    ("Prop"          . 8473)
    ;; Flow
    ("not"           . ?￢)
    ("in"            . ?∈)
    ("not-in"        . ?∉)
    ("for"           . ?∀)
    ("forall"        . ?∀)
    ("some"          . ?∃)
    ("exists"        . ?∃)
    ;; Other
    ("tuple"         . ?⨂)
    ("pipe"          . ?) ;; FIXME: find a non-private char
    ("dot"           . ?•)
    ;; greek
    ("Alpha"         . ?Α)
    ("Beta"          . ?Β)
    ("Gamma"         . ?Γ)
    ("Delta"         . ?Δ)
    ("Epsilon"       . ?Ε)
    ("Zeta"          . ?Ζ)
    ("Eta"           . ?Η)
    ("Theta"         . ?Θ)
    ("Iota"          . ?Ι)
    ("Kappa"         . ?Κ)
    ("Lambda"        . ?Λ)
    ("Mu"            . ?Μ)
    ("Nu"            . ?Ν)
    ("Xi"            . ?Ξ)
    ("Omicron"       . ?Ο)
    ("Pi"            . ?Π)
    ("Rho"           . ?Ρ)
    ("Sigma"         . ?Σ)
    ("Tau"           . ?Τ)
    ("Upsilon"       . ?Υ)
    ("Phi"           . ?Φ)
    ("Chi"           . ?Χ)
    ("Psi"           . ?Ψ)
    ("Omega"         . ?Ω)
    ("alpha"         . ?α)
    ("beta"          . ?β)
    ("gamma"         . ?γ)
    ("delta"         . ?δ)
    ("epsilon"       . ?ε)
    ("zeta"          . ?ζ)
    ("eta"           . ?η)
    ("theta"         . ?θ)
    ("iota"          . ?ι)
    ("kappa"         . ?κ)
    ("lambda"        . ?λ)
    ("mu"            . ?μ)
    ("nu"            . ?ν)
    ("xi"            . ?ξ)
    ("omicron"       . ?ο)
    ("pi"            . ?π)
    ("rho"           . ?ρ)
    ("sigma"         . ?σ)
    ("tau"           . ?τ)
    ("upsilon"       . ?υ)
    ("phi"           . ?φ)
    ("chi"           . ?χ)
    ("psi"           . ?ψ)
    ("omega"         . ?ω))
  "a custom pretty symbol alist"
  :type '(repeat (alist :key-type string :value-type character))
  :group 'vonfry-modules)


(fun! +pretty-code--correct-symbol-bounds (ligature-alist)
  "Prepend non-breaking spaces to a ligature.
This way `compose-region' (called by `prettify-symbols-mode') will use the
correct width of the symbols instead of the width measured by `char-width'."
  (let* ((lig (car ligature-alist))
         (orig (if (stringp lig) lig (car lig)))
         (rep  (if (stringp lig) lig (cdr lig)))
         (len (length rep))
         (ac  (cdr ligature-alist))
         (acc (list ac)))
    (if (and (<= ac (cdr +pretty-code-ligatures-range))
             (>= ac (car +pretty-code-ligatures-range)))
      (progn
        (while (> len 1)
          (setq acc (cons ?\s (cons '(Br . Bl) acc)))
          (setq len (1- len)))
        (cons orig acc))
      ligature-alist)))

(custom! +pretty-code-enabled-modes t
  "List of major modes in which `prettify-symbols-mode' should be enabled.
If t, enable it everywhere. If the first element is 'not, enable it in any mode
besides what is listed."
  :type 'boolean
  :group 'vonfry-modules)

(fun! +pretty-code-init-pretty-symbols-h ()
  "Enable `prettify-symbols-mode'.
If in fundamental-mode, or a mode derived from special, comint, eshell or term
modes, this function does nothing.
Otherwise it builds `prettify-code-symbols-alist' according to
`+pretty-code-symbols-alist' for the current major-mode."
  (unless (or (eq major-mode 'fundamental-mode)
              (eq (get major-mode 'mode-class) 'special)
              (derived-mode-p 'comint-mode 'eshell-mode 'term-mode))
    (when (or (eq +pretty-code-enabled-modes t)
              (if (eq (car +pretty-code-enabled-modes) 'not)
                  (not (memq major-mode (cdr +pretty-code-enabled-modes)))
                (memq major-mode +pretty-code-enabled-modes)))
      (setq prettify-symbols-alist
            (append (cdr (assq major-mode +pretty-code-symbols-alist))
                    (default-value 'prettify-symbols-alist)))
      (when prettify-symbols-mode
        (prettify-symbols-mode -1))
      (prettify-symbols-mode +1))))

(custom! +pretty-code-symbol-font-name "Symbola"
  "Name of the Symbola code ligature font."
  :type 'string
  :group 'vonfry-modules)

(custom! +pretty-code-ligatures-font-name "Fira Code"
  "Name of the ligature font."
  :type 'string
  :group 'vonfry-modules)

(custom! +pretty-code-ligatures-range '(#Xe100 . #Xe18a)
  "ligatures charset range"
  :type '(alist :key-type character :value-type character)
  :group 'vonfry-modules)

(custom! +pretty-code-ligatures
  '(("Fl"                . #Xe100)
    ("Tl"                . #Xe101)
    ("fl"                . #Xe102)
    ("www"               . #Xe103)
    ("--"                . #Xe104)
    ("---"               . #Xe105)
    ("-->"               . #Xe106)
    ("-|"                . #Xe107)
    ("->"                . #Xe108)
    ("->>"               . #Xe109)
    ("-<"                . #Xe10a)
    ("-<<"               . #Xe10b)
    ("-~"                . #Xe10c)
    ("{|"                . #Xe10d)
    ("[|"                . #Xe10e)
    ("]#"                . #Xe10f)
    (".-"                . #Xe110)
    (".."                . #Xe111)
    ("..."               . #Xe112)
    ("..<"               . #Xe113)
    (".?"                . #Xe114)
    (".="                . #Xe115)
    ("::"                . #Xe116)
    (":::"               . #Xe117)
    ("::="               . #Xe118)
    (":="                . #Xe119)
    (":>"                . #Xe11a)
    (":<"                . #Xe11b)
    (";;"                . #Xe11c)
    ("!!"                . #Xe11d)
    ("!!."               . #Xe11e)
    ("/="                . #Xe11f)
    ("!="                . #Xe11f)
    ("!=="               . #Xe120)
    ("/=="               . #Xe120)
    ("?."                . #Xe121)
    ("?:"                . #Xe122)
    ("??"                . #Xe123)
    ("?="                . #Xe124)
    ("**"                . #Xe125)
    ("***"               . #Xe126)
    ("*>"                . #Xe127)
    ("*/"                . #Xe128)
    ("#("                . #Xe129)
    ("#{"                . #Xe12a)
    ("#["                . #Xe12b)
    ("#:"                . #Xe12c)
    ("#!"                . #Xe12d)
    ("#?"                . #Xe12e)
    ("##"                . #Xe12f)
    ("###"               . #Xe130)
    ("####"              . #Xe131)
    ("#="                . #Xe132)
    ("#_"                . #Xe133)
    ("#_("               . #Xe134)
    ("/*"                . #Xe135)
    ; ("/="                . #Xe136)
    ; ("/=="               . #Xe137)
    ("/>"                . #Xe138)
    ("//"                . #Xe139)
    ("///"               . #Xe13a)
    ("_|_"               . #Xe13d)
    ("__"                . #Xe13e)
    ; Don't use #X110088 - # X110093
    ("&&"                . #Xe13f)
    ("|-"                . #Xe140)
    ("|->"               . #Xe141)
    ("|}"                . #Xe142)
    ("|]"                . #Xe143)
    ("||"                . #Xe144)
    ("||-"               . #Xe145)
    ("|||>"              . #Xe146)
    ("||="               . #Xe147)
    ("||>"               . #Xe148)
    ("|="                . #Xe149)
    ("|=>"               . #Xe14a)
    ("|>"                . #Xe14b)
    ("$>"                . #Xe14c)
    ("++"                . #Xe14d)
    ("+++"               . #Xe14e)
    ("+>"                . #Xe14f)
    ("=:="               . #Xe150)
    ("=!="               . #Xe151)
    ("=="                . #Xe152)
    ("==="               . #Xe153)
    ("==>"               . #Xe154)
    ("=>"                . #Xe155)
    ("=>>"               . #Xe156)
    ("=<<"               . #Xe157)
    ("=/="               . #Xe158)
    (">-"                . #Xe159)
    (">->"               . #Xe15a)
    (">:"                . #Xe15b)
    (">="                . #Xe15c)
    (">=>"               . #Xe15d)
    (">>"                . #Xe15e)
    (">>-"               . #Xe15f)
    (">>="               . #Xe160)
    (">>>"               . #Xe161)
    ("<-"                . #Xe162)
    ("<--"               . #Xe163)
    ("<-|"               . #Xe164)
    ("<->"               . #Xe165)
    ("<-<"               . #Xe166)
    ("<:"                . #Xe167)
    ("<!--"              . #Xe168)
    ("<*"                . #Xe169)
    ("<*>"               . #Xe16a)
    ("<|"                . #Xe16b)
    ("<||"               . #Xe16c)
    ("<|||"              . #Xe16d)
    ("<|>"               . #Xe16e)
    ("<$"                . #Xe16f)
    ("<$>"               . #Xe170)
    ("<+"                . #Xe171)
    ("<+>"               . #Xe172)
    ("<="                . #Xe173)
    ("<=|"               . #Xe174)
    ("<=="               . #Xe175)
    ("<==>"              . #Xe176)
    ("<=>"               . #Xe177)
    ("<=<"               . #Xe178)
    ("<>"                . #Xe179)
    ("<<"                . #Xe17a)
    ("<<-"               . #Xe17b)
    ("<<="               . #Xe17c)
    ("<<<"               . #Xe17d)
    ("<~"                . #Xe17e)
    ("<~>"               . #Xe17f)
    ("<~~"               . #Xe180)
    ("</"                . #Xe181)
    ("</>"               . #Xe182)
    ("~-"                . #Xe183)
    ("~@"                . #Xe184)
    ("~="                . #Xe185)
    ("~>"                . #Xe186)
    ("~~"                . #Xe187)
    ("~~>"               . #Xe188)
    ("^="                . #Xe189)
    ("%%"                . #Xe18a)
    (("and"    . "/\\")  . #Xe13b)
    (("or"     . "\\/")  . #Xe13c)
    (("return" . "|->")  . #Xe141)
    (("yield"  . "|->")  . #Xe141))
  "pretty code ligatures"
  :type '(repeat (alist :key-type (choice string
                                          (alist :key-type string
                                                 :value-type string))
                        :value-type character))
  :group 'vonfry-modules)

(fun! +pretty-code-setup-h ()
  (dolist (charset (mapcar 'string-to-char (-filter 'stringp
                                                    +pretty-code-symbols)))
    (set-fontset-font t charset
                      +pretty-code-ligatures-font-name
                      nil 'append)
    (set-fontset-font t charset
                      +pretty-code-symbol-font-name
                      nil 'append))
  (dolist (charset (mapcar 'cdr company-coq-prettify-symbols-alist))
    (set-fontset-font t charset
                      (font-spec :family +pretty-code-symbol-font-name
                                 :size vonfry-fontsize)
                      nil 'prepend))
  (set-fontset-font t +pretty-code-ligatures-range
                    (font-spec :family +pretty-code-ligatures-font-name
                               :size  vonfry-fontsize)
                    nil 'prepend)
  (setq-default prettify-symbols-alist
                (append prettify-symbols-alist
                        +pretty-code-symbols
                        (mapcar '+pretty-code--correct-symbol-bounds
                                +pretty-code-ligatures))))

(fun! +pretty-code-mode-with-ligatures (mode append-to &optional remove-from)
  "set mode with other ligatures with arguments append-to or remove-from. Both
of them are a list which contains alist. `(list '(ligstr . charcode))'"
  (hook~! mode
          (lambda ()
            (setq prettify-symbols-alist
                  (append (mapcar '+pretty-code--correct-symbol-bounds
                                  append-to)
                          prettify-symbols-alist))
            (mapcar (lambda (i)
                      (setq prettify-symbols-alist
                            (delete i prettify-symbols-alist))
                      nil)
                    remove-from))))
