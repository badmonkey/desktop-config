;;; -*- lexical-binding: t; -*-
;;;
;;; init-settings --- Personal settings

(defvar user-home-dir (getenv "HOME"))


;;  classify buffers
(defvar meta-buffer-regexp-list
  (list (rx "*"))
  "List of Rx for matching buffers that are meta-buffer")

;; transient can be purged if we're not in the middle of another interactive
(defvar transient-buffer-regexp-list
  (list (rx "*magit-") (rx "*helm") (rx "*straight-") (rx "*flycheck-") (rx "*swiper*"))
  "List of Rx for matching buffers that are transient")

;; check "*magit-" vs "magit-"
(defvar hidden-buffer-regexp-list
  (list (rx " *"))
  "List of Rx for matching buffers that are hidden")


;; simple settings
(setq user-full-name "Set full-name in local-settings.el"
  user-mail-address "Set mail-address in local-settings.el")


;; Backup/Autosave
(setq auto-save-file-name-transforms
  `((".*" ,temporary-file-directory t)))


(defvar backup-dir (expand-file-name ".backup" user-home-dir))
(setq backup-directory-alist (list (cons "." backup-dir)))

(setq desktop-dirname user-emacs-directory)
(setq desktop-base-file-name "desktop.session")
(setq desktop-base-lock-name "desktop.lock")


(when (startup? 'with-macos)
  ;;  used for compiling and callign stuff with eshell
  (setenv "PATH"
    (concat
      "/usr/local/bin" ":"
      "/bin" ":"
      "/usr/bin" ":"
      (getenv "PATH")
      )
    )

  ;;  used for loading flyc make and the like
  (setq exec-path
    (append exec-path
      '("~/bin"
         "/usr/local/bin"
         "/bin"
         "/usr/bin"
         ))))

;;(setq vc-handled-backends '(Git))


;; (setq scroll-error-top-bottom t)


(setq frame-title-format "%b%+")
;; (setq frame-title-format (list "%b (" user-login-name "@" system-name ")"))
;; frame-title-format '((:eval  ; TODO: maybe better in "* Better Defaults"
;;                        (let ((project-name (projectile-project-name)))
;;                          (unless (string= "-" project-name)
;;                            (format "%s| " project-name))))
;;                       "%b"))  ; project-name| file-name


;; Get rid of tool bar, menu bar and scroll bars.  On OS X we preserve the menu
;; bar, since the top menu bar is always visible anyway, and we'd just empty it
;; which is rather pointless.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (and
        (startup-unless 'darwin)
        (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))


(setq-default scroll-conservatively 101)

(setq-default x-stretch-cursor t)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; short yes/no questions
(fset 'yes-or-no-p #'y-or-n-p)

;; clipboard mode
(setq select-enable-clipboard t
      select-enable-primary t)


;; transient mode
(setq-default transient-mark-mode t)

(delete-selection-mode)


;; treat CamelCase as words
;; (global-subword-mode 1)
(global-superword-mode 1)

(customize-set-variable 'make-pointer-invisible nil)
(mouse-avoidance-mode 'exile)

;; Frame movement (shift arrow)
(windmove-default-keybindings)
(setq windmove-wrap-around t)


(customize-set-variable 'mouse-yank-at-point t)


;;; utf-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment "UTF-8")


;; make compile-command local
(make-variable-buffer-local 'compile-command)


;; (setq
;;   ring-bell-function 'ignore
;;   auth-sources my/auth-sources
;;   tramp-default-method "ssh"
;;   inhibit-startup-message t
;;   inhibit-startup-echo-area-message t
;;   initial-scratch-message nil
;;   use-dialog-box nil
;;   tab-always-indent 'complete)

;; (setq
;;   backup-by-copying t
;;   backup-directory-alist `(("." . ,my/backup-dir))
;;   auto-save-file-name-transforms `((".*" ,my/backup-dir t))
;;   delete-old-versions t
;;   kept-new-versions 6
;;   kept-old-versions 2
;;   version-control t)

;; (setq tab-bar-show 1
;;   tab-bar-new-tab-choice #'crux-create-scratch-buffer)

;; (column-number-mode t)

(setq warning-suppress-types '((native-compiler lexical-binding))
  warning-suppress-log-types '((native-compiler)))

(setq warning-minimum-level :error)

;; https://gitlab.com/jdm204/dotfiles/-/blob/master/config.org

(provide 'init-settings)
;;; init-settings.el ends here
