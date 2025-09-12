;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-visuals --- Visual settings

;; https://github.com/Fuco1/indicators.el

;; Theme
(load-theme 'hipster t)

;; clean up the status bar
(use-package diminish
  :config
  ;; :diminish 'subword-mode
  ;; :diminish 'superword-mode
  (diminish (list 'indent-guide-mode 'subword-mode))

  :diminish 'global-whitespace-mode)


(use-package fira-code-mode
  :if (startup? 'with-heavy-visuals)
  :custom
  (fira-code-mode-enable-hex-literal nil)
  (setq fira-code-mode-disabled-ligatures '("x"))
  :hook prog-mode
  :diminish fira-code-mode)


(use-package highlight-indent-guides
  :config
  ;; (set-face-background 'highlight-indent-guides-odd-face "darkgray")
  ;; (set-face-background 'highlight-indent-guides-even-face "darkred")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-top-character-face "darkred")
  (setq highlight-indent-guides-responsive 'top)
  (setq highlight-indent-guides-method 'bitmap)
  (setq highlight-indent-guides-bitmap-function 'highlight-indent-guides--bitmap-dots)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

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
  :if (startup? 'with-heavy-visuals)
  :init
  ;; (setq beacon-size  7
  ;;       beacon-color "#f85e9f")
  ;; (beacon-color "#f1fa8c")
  (beacon-mode 1)
  :diminish beacon-mode)

(use-package hl-todo
  :config
  (global-hl-todo-mode))

(use-package indicators)

(use-package line-reminder
  :config
  (setq line-reminder-show-option 'indicators)
  (global-line-reminder-mode t))

;; after flycheck?
(use-package sideline
  :init
  (setq sideline-backends-right '(sideline-flycheck))
  :hook (flycheck-mode . sideline-mode))

(use-package sideline-flycheck
  :init
  (setq sideline-flycheck-display-mode 'line)
  :hook (flycheck-mode . sideline-flycheck-setup))


(use-package visible-mark
  :if (startup? 'with-heavy-visuals)
  :init
  (global-visible-mark-mode)
  :custom
  (visible-mark-faces '(visible-mark-face2 visible-mark-face1))
  (visible-mark-max 2))

(use-package aggressive-indent
  :init
  (global-aggressive-indent-mode 1))

(use-package all-the-icons)

;; (use-package auto-dim-other-buffers
;;   :init
;;   (add-hook 'after-init-hook (lambda ()
;;   (when (fboundp 'auto-dim-other-buffers-mode)
;;     (auto-dim-other-buffers-mode t)))))


(provide 'init-bundle-visuals)
;;; init-bundle-visuals.el ends here
