;;; init-settings --- Personal settings
;;; Commentary:
;;; Code:


(defvar user-home-dir (getenv "HOME"))


;; simple settings
(setq user-full-name "Michael Fagan"
      user-mail-address "michael.charles.fagan@gmail.com")



;;  set default font
(set-frame-font "Fira Code 18" nil t)
;; (set-frame-font "Inconsolata 18" nil t)


;; Backup/Autosave
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(defvar backup-dir (f-join user-home-dir ".backup"))
(setq backup-directory-alist (list (cons "." backup-dir)))

(setq desktop-dirname user-emacs-directory)
(setq desktop-base-file-name "desktop.session")
(setq desktop-base-lock-name "desktop.lock")


(when (string-equal system-type "darwin")
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


(setq vc-handled-backends nil)


;; emacs machine settings
(setq load-prefer-newer t)


;; disable startup message
(setq inhibit-startup-message t)

;; Opt out from the startup message in the echo area by simply disabling this
;; ridiculously bizarre thing entirely.
(fset 'display-startup-echo-area-message #'ignore)

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
(when (and (not (eq system-type 'darwin)) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))


(setq-default scroll-conservatively 101)

(defvar global-line-max-width)
(setq global-line-max-width 100)

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

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

(delete-selection-mode 1)

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



(provide 'init-settings)
;;; init-settings.el ends here
