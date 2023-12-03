(in-package #:nyxt-user)

(define-configuration context-buffer
  ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-value%))))

(define-configuration prompt-buffer
  ((default-modes (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

(defun play-video-at-url (url)
  (uiop:run-program (list "mpv" (format nil "ytdl://~A" (render-url url)))))

(define-command-global play-video-in-current-page
    (&optional (buffer (current-buffer)))
  "Play video in the currently open buffer."
  (play-video-at-url (url buffer)))

(define-command-global follow-hint-play-video
    (&optional (buffer (current-buffer)))
  "Prompt for element hints and open them in a video player."
  (nyxt/mode/hint:query-hints "Interact with element"
    (lambda (results) (play-video-at-url (url (first results))))))

(define-configuration document-mode
  ((keyscheme-map
    (define-keyscheme-map
        "vonfry-keybinding"
        (list :import %slot-value%)
        nyxt/keyscheme:vi-normal
        (list "a m" 'play-video-in-current-page
              "; m" 'follow-hint-play-video
              "g B" 'list-buffers
              "g L" 'list-history
              "d a" 'delete-all-buffers
              "d d" 'delete-buffer
              "d o" 'delete-other-buffers
              "u"   'reopen-last-buffer
              "U"   'reopen-buffer)))))
