;;; -*- lexical-binding: t; -*-
;;;
;;; init-settings-visuals --- Configure visual functionality


(defvar global-line-max-width 100
  "common line max width")

(defvar global-tab-width 4
  "common tab width")

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; Fonts
;;  set default font
;; (set-frame-font "Fira Code 18" nil t)
;; (set-frame-font "Inconsolata 18" nil t)

(set-frame-font "Fira Code 10" nil t)
;; (set-default-font "Fira Code")
;;(set-face-attribute 'default t :font "Hack-Regular" )
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")

(set-fontset-font
  t 'symbol
  (font-spec :family "Symbola") nil 'prepend)

;; Line mode
(global-display-line-numbers-mode t)
(set-default 'truncate-lines t)

;; max line width indicator
(setq-default display-fill-column-indicator-column 80)
;; (setq-default display-fill-column-indicator-character ?|)
(global-display-fill-column-indicator-mode t)


;; https://lists.gnu.org/archive/html/help-gnu-emacs/2015-12/msg00189.html
(setq-default indicate-buffer-boundaries t)

;; Indent setting
(setq-default tab-always-indent nil)
(setq-default indent-tabs-mode nil)

(defun custom-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
          (tab-width (or width tab-width))
          (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq-default tab-width global-tab-width)
(setq-default c-basic-offset global-tab-width)
(setq tab-stop-list (custom-generate-tab-stops))

(setq lisp-indent-offset 2)

;;(electric-indent-mode 1)


;; turn on highlight matching brackets when cursor is on one
(show-paren-mode t)


;; fringe
(setq-default left-fringe-width 10
  right-fringe-width 10)


;; Emoji set
;; (set-fontset-font t 'unicode "Noto Color Emoji" nil 'prepend)


;; whitespace settings
(setq whitespace-line-column global-line-max-width)
(setq-default fill-column global-line-max-width)

(setq whitespace-style
  (quote (face trailing lines spaces tabs newline space-mark tab-mark newline-mark)))

;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
(setq whitespace-display-mappings
  ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
  '((space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
     (newline-mark 10 [182 10]) ; LINE FEED,
     (tab-mark 9 [9655 9] [92 9]) ; tab
     ))

(whitespace-mode)


;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(hl-line ((t (:background "gray5"))))
;; '(hydra-posframe-border-face ((t (:background "#6272a4"))))
;; '(markdown-header-delimiter-face ((t (:foreground "mediumpurple"))))
;; '(markdown-header-face-1 ((t (:foreground "violet" :weight bold :height 1.0))))
;; '(markdown-header-face-2 ((t (:foreground "lightslateblue" :weight bold :height 1.0))))
;; '(markdown-header-face-3 ((t (:foreground "mediumpurple1" :weight bold :height 1.0))))
;; '(markdown-link-face ((t (:background "#0e1014" :foreground "#bd93f9"))))
;; '(markdown-list-face ((t (:foreground "mediumpurple"))))
;; '(markdown-pre-face ((t (:foreground "#bd98fe"))))
;;  '(whitespace-empty ((t (:foreground "red" :background "red"))))
;;  '(whitespace-indentation ((t (:foreground "yellow" :background "black"))))
;;  '(whitespace-line ((t (:foreground unspecified :underline "DarkRed"))))
;;  '(whitespace-newline ((t (:foreground "blue" :background "black"))))
;;  '(whitespace-space ((t (:foreground "gray25" :background "black"))))
;;  '(whitespace-space-after-tab ((t (:foreground "yellow" :background "black"))))
;;  '(whitespace-space-before-tab ((t (:foreground "red" :background "black"))))
;;  '(whitespace-tab ((t (:foreground "blue" :background "black"))))
;;  '(whitespace-trailing ((t (:bold t :foreground "red" :background "black"))))
;;  )


(provide 'init-settings-visual)
;;; init-settings-visual.el ends here
