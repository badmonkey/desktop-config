;;; -*- lexical-binding: t; -*-
;;;
;;; init-startup-features --- Settings for controlling what starts

;;
;;;;;;;;; user controlled settings ;;;;;;;;
;;

;; available: with-heavy-visuals with-profile with-git with-load-custom
;; with-debug with-elisp-lint with-internet
;; lang-erlang lang-pony lang-zig lang-rust lang-go lang-python
;; with-graphics
(defvar user-startup-features
  `(with-heavy-visuals with-git with-load-custom with-internet with-debug
     lang-erlang lang-rust lang-go)
  "List of user features to process during startup")


;;
;;;;;;;;; startup functions ;;;;;;;;
;;
(defun startup? (name) (seq-position user-startup-features name))

(defun startup-unless (name) (not (seq-position user-startup-features name)))

;; func so we can programatically remove features
(defmacro startup-disable (targets)
  `(setq user-startup-features
     (seq-remove (lambda (x) (seq-position ,targets x)) user-startup-features)))


;;
;;;;;;;;; Update features depending on platform ;;;;;;;;
;;
(startup-disable `(with-graphics))
(when (display-graphic-p)
  (push 'with-graphics user-startup-features))

(pcase system-type
  ('darwin
    (message "Platform macos"))
  ((or 'ms-dos 'windows-nt 'cygwin)
    (progn
      (message "Platform windows")
      (startup-disable `(with-heavy-visuals))))
  ('gnu/linux
    (message "Platform linux"))
  (_
    (message "unknown platform %s" system-type)))


(provide 'init-startup-features)
;;; init-startup-features.el ends here
