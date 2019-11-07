;;; init-settings --- Personal settings
;;; Commentary:
;;; Code:


;; simple settings
(setq user-full-name "Michael Fagan"
      user-mail-address "michael.charles.fagan@gmail.com")


;; Backup/Autosave
(setq auto-save-file-name-transforms
	  `((".*" ,temporary-file-directory t)))

(defvar backup-dir (concat "/home/" (user-login-name) "/.backup/"))
(setq backup-directory-alist (list (cons "." backup-dir)))


(setq vc-handled-backends nil)


;; emacs machine settings
(setq load-prefer-newer t)


;; disable startup message
(setq inhibit-startup-message t)

;; Opt out from the startup message in the echo area by simply disabling this
;; ridiculously bizarre thing entirely.
(fset 'display-startup-echo-area-message #'ignore)

;; Get rid of tool bar, menu bar and scroll bars.  On OS X we preserve the menu
;; bar, since the top menu bar is always visible anyway, and we'd just empty it
;; which is rather pointless.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (and (not (eq system-type 'darwin)) (fboundp 'menu-bar-mode))
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; disable the annoying bell ring
(setq ring-bell-function 'ignore)

;; short yes/no questions
(fset 'yes-or-no-p #'y-or-n-p)

;; clipboard mode
(setq x-select-enable-clipboard t
      x-select-enable-primary t)


;; transient mode
(setq-default transient-mark-mode t)


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


(provide 'init-settings)
;;; init-settings.el ends here
