;;; init-visuals --- Visual settings
;;; Commentary:
;;; Code:


(defvar global-line-max-width)
(setq global-line-max-width 100)

;; Theme
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(load-theme 'hipster t)

;;(set-face-attribute 'default t :font "Hack-Regular" )


;; Line mode
(global-linum-mode t)
(set-default 'truncate-lines t)


;; Indent setting
(setq-default tab-always-indent nil)

(defun monkey-generate-tab-stops (&optional width max)
  "Return a sequence suitable for `tab-stop-list'."
  (let* ((max-column (or max 200))
         (tab-width (or width tab-width))
         (count (/ max-column tab-width)))
    (number-sequence tab-width (* tab-width count) tab-width)))

(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq tab-stop-list (monkey-generate-tab-stops))

(set-variable 'python-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)

;;(electric-indent-mode 1)


;; highlight mode
(when window-system
  (global-hl-line-mode 1))


;; turn on highlight matching brackets when cursor is on one
(show-paren-mode t)


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

(global-whitespace-mode 1)


;; fringe
(setq-default left-fringe-width 10
              right-fringe-width 10)

;; clean up the status bar
(use-package diminish
  :config
  :diminish 'global-whitespace-mode)
  ;; (progn (add-hook 'whitespace-mode-hook (lambda () (diminish 'whitespace-mode)))))

(use-package indent-guide
  :load-path contrib-load-path
  :config
  (indent-guide-global-mode)
  (set-face-foreground 'indent-guide-face "DarkRed")
  (setq indent-guide-recursive t)
  (setq indent-guide-char "|")
  (setq indent-guide-delay 0.2))

(use-package rainbow-delimiters
  :init
  (eval-when-compile
    ;; Silence missing function warnings
    (declare-function rainbow-delimiters-mode "rainbow-delimiters.el"))
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package color-identifiers-mode
   :init)
   ;; :diminish 'color-identifiers-mode
   ;; (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package beacon
  :init
  ;; (setq beacon-size  7
  ;;       beacon-color "#f85e9f")
  ;; (beacon-color "#f1fa8c")
  (beacon-mode 1)
  :diminish beacon-mode)

(use-package hl-todo
  :load-path contrib-load-path
  :config
  (global-hl-todo-mode))


(use-package all-the-icons)



(provide 'init-visuals)
;;; init-visuals.el ends here
