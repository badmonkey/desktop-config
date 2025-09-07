;;; -*- lexical-binding: t; -*-
;;;
;;; init-startup-features --- Settings for controlling what starts

;;
;;;;;;;;; user controlled settings ;;;;;;;;
;;

;; available: start-heavy-visuals start-profile start-git start-load-custom
;; start-debug start-elisp-lint
;; start-erlanf start-pony start-zig start-rust start-go start-python
(defvar user-startup-features `(start-heavy-visuals start-git start-load-custom
                                 start-debug start-erlang start-rust start-go)
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
;;;;;;;;; Update features depednign on platform ;;;;;;;;
;;
(startup-disable `(graphics))
(when (display-graphic-p)
  (push 'graphics user-startup-features))

(pcase system-type
  ('darwin
    (message "Platform macos"))
  ((or 'ms-dos 'windows-nt 'cygwin)
    (progn
      (message "Platform windows")
      (startup-disable `("slow-visuals"))))
  ('gnu/linux
    (message "Platform linux"))
  (_
    (message "unknown platform %s" system-type)))


(provide 'init-startup-features)
;;; init-startup-features.el ends here
