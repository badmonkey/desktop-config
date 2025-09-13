;;; -*- lexical-binding: t; -*-
;;;
;;; init-startup-features --- Settings for controlling what starts

;;
;;;;;;;;; user controlled settings ;;;;;;;;
;;

;; available: with-heavy-visuals with-profiler with-git with-load-custom
;; with-debug with-trace with-elisp-lint with-internet with-menubar with-dashboard
;; with-keyfreq with-flycheck
;; lang-erlang lang-pony lang-zig lang-rust lang-go lang-python
;; with-graphics with-macos with-windows with-linux
(defvar user-startup-features
  `(with-heavy-visuals with-git with-load-custom with-internet with-dashboard
     with-debug
     lang-erlang lang-rust lang-go)
  "List of user features to process during startup")

(defvar startup-failures nil
  "List of startup files that failed to load")

;;
;;;;;;;;; startup functions ;;;;;;;;
;;

;; (defmacro startup? (name &rest args)
;;   (if (and args (listp args))
;;     `(and
;;        (seq-position user-startup-features ,name)
;;        (seq-every-p #'(lambda (x) (seq-position user-startup-features x) ,@args)))
;;     `(seq-position user-startup-features ,name)))

(defun startup? (name &optional name2)
  (if name2
    (and
      (seq-position user-startup-features name)
      (seq-position user-startup-features name2))
    (seq-position user-startup-features name)))

(defun startup-unless (name) (not (seq-position user-startup-features name)))

;; func so we can programatically remove features
(defmacro startup-disable (targets)
  `(setq user-startup-features
     (seq-remove (lambda (x) (seq-position ,targets x)) user-startup-features)))

;; func so we can programatically enable features
(defmacro startup-enable (targets)
  `(setq user-startup-features
     (seq-union ,targets user-startup-features)))


(defmacro startup-message (text &rest args)
  `(message ,text ,@args))

;; (defmacro startup-message (text &rest args)
;;   (if (startup? 'with-debug)
;;     `(message ,text ,@args)
;;     `(ignore)))


(defun require-all (which)
  (let* ((glob-pattern (format "%s/init-%s-*.el" user-startup-directory which))
          (matching-files (file-expand-wildcards glob-pattern)))
    (startup-message "Searching '%s'" glob-pattern)
    (mapc
      #'(lambda (x)
          (let* ((filename (file-name-nondirectory x))
                  (filesym (intern (file-name-sans-extension filename))))
            (try-require filesym)))
      matching-files)))

(defun try-require (filesym)
  (startup-message "loading %s" filesym)
  (condition-case ex
    (require filesym)
    ('error
      (push filesym startup-failures)
      (message "!! failed to load %s error: %s" filesym ex))))

;;
;;;;;;;;; Update features depending on platform ;;;;;;;;
;;
(when (display-graphic-p)
  (startup-enable `(with-graphics)))

(pcase system-type
  ('darwin
    (progn
      (message "Platform macos")
      (startup-enable `(with-menubar with-macos))))
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


(provide 'init-features)
;;; init-startup-features.el ends here
