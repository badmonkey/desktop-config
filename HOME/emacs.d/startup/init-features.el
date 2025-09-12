;;; -*- lexical-binding: t; -*-
;;;
;;; init-startup-features --- Settings for controlling what starts

;;
;;;;;;;;; user controlled settings ;;;;;;;;
;;

;; available: with-heavy-visuals with-profile with-git with-load-custom
;; with-debug with-elisp-lint with-internet with-menubar with-dashboard
;; lang-erlang lang-pony lang-zig lang-rust lang-go lang-python
;; with-graphics with-macos with-windows with-linux
(defvar user-startup-features
  `(with-heavy-visuals with-git with-load-custom with-internet with-dashboard
     with-debug
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

;; func so we can programatically enable features
(defmacro startup-enable (targets)
  `(setq user-startup-features
     (cl-union targets user-startup-features)))


;;
;;;;;;;;; Update features depending on platform ;;;;;;;;
;;
(when (display-graphic-p)
  (startup-enable `(with-graphics)))

(pcase system-type
  ('darwin
    (progn
      (message "Platform macos")
      (startup-enable `(with-menubar with-macos)))
  ((or 'ms-dos 'windows-nt 'cygwin)
    (progn
      (message "Platform windows")
      (startup-enable `(with-windows))
      (startup-disable `(with-heavy-visuals))))
    ('gnu/linux
      (progn
        (message "Platform linux")
        (startup-enable `(with-linux))))
  (_
    (message "unknown platform %s" system-type)))


(provide 'init-startup-features)
;;; init-startup-features.el ends here
