;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-startup-features --- Settings for controlling what starts

;;
;;;;;;;;; user controlled settings ;;;;;;;;
;;

;; available: slow-visuals profile git load-custom debug elisp-lint
(defvar user-startup-allow-features `("slow-visuals" "git" "load-custom")
  "List of user features to process during startup")
;; (setq user-startup-allow-features `("slow-visuals" "git" "load-custom" "debug"))

;; available: erlang pony zig java rust go python
(defvar user-startup-allow-langs `("erlang" "rust" "go")
  "List of optional langs to load")


;;
;;;;;;;;; startup functions ;;;;;;;;
;;
(defun startup-lang (name) (-contains? user-startup-allow-langs name))

(defun startup-when (name) (-contains? user-startup-allow-features name))

(defun startup-unless (name) (not (-contains? user-startup-allow-features name)))

;; func so we can programatically remove features
(defmacro startup-disable (targets)
  `(setq user-startup-allow-features
     (-remove (lambda (x) (-contains? ,targets x)) user-startup-allow-features)))


;;
;;;;;;;;; Update features depednign on platform ;;;;;;;;
;;
(startup-disable `("graphics"))
(when (display-graphic-p)
  (push "graphics" user-startup-allow-features))

(cl-case system-type
  (darwin
    (message "Platform macos"))
  ((ms-dos windows-nt cygwin)
    (progn
      (message "Platform windows")
      (startup-disable `("slow-visuals"))))
  (gnu/linux
    (message "Platform linux"))
  (otherwise
    (message "unknown platform %s" system-type)))


(provide 'init-startup-features)
;;; init-startup-features.el ends here
