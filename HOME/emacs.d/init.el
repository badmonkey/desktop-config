;;; -*- lexical-binding: t; -*-
;;;
;;; init.el --- Configure all the things

;;
;;;;;;;; Setup variables needed for loading packages ;;;;;;;;
;;

(defvar user-sitelisp-directory nil
  "Directory with user's site-lisp files saved from the internet")

(defvar user-startup-directory nil
  "Directory with user's startup files")

(defvar startup-banner-file nil
  "The startup banner logo")

(let* ((current-init-file (or load-file-name (buffer-file-name)))
        (current-emacs-directory (file-name-directory current-init-file)))
  (setq user-sitelisp-directory (expand-file-name "site-lisp" current-emacs-directory))
  (setq user-startup-directory (expand-file-name "startup" current-emacs-directory))
  (setq startup-banner-file (expand-file-name "logo.png" current-emacs-directory))

  (setq user-lisp-directory (expand-file-name "lisp" current-emacs-directory))

  (add-to-list 'load-path user-sitelisp-directory)
  (add-to-list 'load-path user-startup-directory)

  (add-to-list 'custom-theme-load-path (expand-file-name "themes" current-emacs-directory))

  (when (not (equal current-emacs-directory user-emacs-directory))
    (message "Adding %s to paths for site local customization" user-emacs-directory)

    ;; We're being loaded out of the user-emacs-directory, add paths to support
    ;; site-local customization
    (add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
    (add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
    )
  )

;; location for customization save
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; location for local features configurations
(setq local-features-file (expand-file-name "local-features.el" user-emacs-directory))

;; location for local settings
(setq local-settings-file (expand-file-name "local-settings.el" user-emacs-directory))


;; Set eln-cache dir
;;(when (boundp 'native-comp-eln-load-path)
;;  (startup-redirect-eln-cache (expand-file-name "eln-cache" user-emacs-directory)))

(setq native-comp-jit-compilation t
  native-comp-async-report-warnings-errors nil
  native-comp-speed 3)


;;
;;;;;;;; Setup startup features ;;;;;;;;
;;

;; set up system for controlling what starts
(require 'init-features)

(when (file-readable-p local-features-file)
  (load local-features-file :noerror))

(startup-message "features: %s" user-startup-features)


;;
;;;;;;;; bootstrap straight ;;;;;;;;
;;
(startup-message "### Starting straight package management ###")
(custom-set-variables
  '(straight-repository-branch "develop")
  '(straight-check-for-modifications '(check-on-save find-when-checking))
  '(straight-use-package-by-default t)
  '(straight-vc-git-default-clone-depth 1))

(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
       (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq straight-cache-autoloads t)

;; (require 'init-package)

;; clean up the status bar
(use-package diminish
  :config
  :diminish 'global-whitespace-mode)

;; profiler
(use-package esup
  :if (startup? 'with-profiler))


;;
;;;;;;;; Fiddle with the garbage collector ;;;;;;;;
;;


(add-function :after
  after-focus-change-function
  (lambda () (unless (frame-focus-state) (garbage-collect))))

(use-package gcmh
  :init
  (gcmh-mode t)
  :config
  (setq garbage-collection-messages t)
  :hook
  (after-init . garbage-collect)

  ;; gc-cons-* values modified in 'early-init.el'
  (emacs-startup . (lambda ()
                     (setq gc-cons-percentage 0.1
                       gc-cons-threshold (* 32 1024 1024)
                       gcmh-high-cons-threshold (* 32 1024 1024)
                       gcmh-idle-delay 30))))


;;
;;;;;;;; Start normal package loading ;;;;;;;;
;;
(startup-message "### Loading settings ###")

(try-require 'init-settings)
(require-all "settings")

(when (file-readable-p local-settings-file)
  (load local-settings-file :noerror))


;; https://github.com/zacwood9/.emacs.d/blob/master/lisp/init-package.el
;; https://github.com/purcell/emacs.d/blob/master/lisp/init-markdown.el

;; Load library packages
(startup-message "### Loading libraries ###")
(use-package dash)
(use-package s)
(use-package s-buffer)
(use-package f)

(require-all "defun")

(startup-message "### Loading packages ###")
(require-all "bundle")
(require-all "mode")
(require-all "lang")

(startup-message "### Loading interactive libraries ###")
(require-all "ifun")
(require-all "hydra")

(startup-message "### Preparing keybindings ###")
(try-require 'init-kill-keybinds)

(general-auto-unbind-keys)
(require-all "bind")
(general-auto-unbind-keys t)

(startup-message "### Starting server mode ###")
(unless (seq-empty-p startup-failures)
  (message "!! Encountered errors while loading the following: %s" startup-failures))

(try-require 'init-server)


(when (startup? 'with-load-custom)
  (load custom-file :noerror))
