;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-visuals --- Visual settings

;; https://github.com/Fuco1/indicators.el

;; Theme
(load-theme 'hipster t)

(diminish (list 'indent-guide-mode 'subword-mode))

(use-package fira-code-mode
  :if (startup? 'with-heavy-visuals)
  :custom
  (fira-code-mode-enable-hex-literal nil)
  (setq fira-code-mode-disabled-ligatures '("x"))
  :hook prog-mode
  :diminish fira-code-mode)


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
  (visible-mark-faces '(visible-mark-face1 visible-mark-face2))
  (visible-mark-max 1))

(use-package aggressive-indent
  :init
  (global-aggressive-indent-mode 1))

(use-package all-the-icons)

;; (use-package auto-dim-other-buffers
;;   :init
;;   (add-hook 'after-init-hook (lambda ()
;;   (when (fboundp 'auto-dim-other-buffers-mode)
;;     (auto-dim-other-buffers-mode t)))))

;; https://github.com/tbanel/uniline/tree/dd4c99ef2900d366f98384c6bbb7b30c60ddbff3

(use-package uniline
  :bind ("C-<insert>" . uniline-mode))

;; https://github.com/misohena/el-easydraw

;; https://doc.endlessparentheses.com/Fun/artist-mode.html
;; (artist-mode &optional ARG)


(provide 'init-bundle-visuals)
;;; init-bundle-visuals.el ends here
