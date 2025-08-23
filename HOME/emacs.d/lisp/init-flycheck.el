;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-flycheck --- Configure flycheck


(use-package flycheck
  :diminish 'flycheck-mode
  :config
  (setq-default flycheck-check-syntax-automatically '(save mode-enabled))
  :init
  ;; (setq flycheck-python-pylint-executable "pylint-shim-pylava")
  ;; (setq flycheck-pylintrc "setup.cfg")
  (setq flycheck-temp-prefix "__flycheck_")
  (setq flycheck-indication-mode nil)
  ;; (setq flycheck-indication-mode 'left-fringe)
  (setq flycheck-highlighting-mode 'lines)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc python-pylint python-flake8 python-mypy))
  (global-flycheck-mode))


;; (when (display-graphic-p)
;;   (use-package flycheck-posframe
;;     :after flycheck
;;     :config
;;     (flycheck-posframe-configure-pretty-defaults)
;;     ;; frame-center  frame-top-center frame-bottom-center
;;     ;; window-bottom-right-corner
;;     (setq flycheck-posframe-position 'frame-bottom-center)
;;     (setq flycheck-posframe-border-width 2)
;;     (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)

;;     :custom-face
;;     (flycheck-posframe-border-face ((t (:foreground "DarkRed")))))
;;   )


(use-package flycheck-pony)

(use-package flycheck-swift
  :after flycheck
  :config
  (flycheck-swift-setup))

;; (use-package flycheck-swiftlint
;;   :after flycheck
;;   :config
;;   (flycheck-swiftlint-setup))

;; (use-package flycheck-indicator
;;   :hook (flycheck-mode . flycheck-indicator-mode))

(with-eval-after-load 'flycheck
  (flycheck-def-config-file-var flycheck-swiftlintrc swiftlink ".swiftlink.yml")
  (flycheck-def-executable-var swiftlint "swiftlint")

  (flycheck-define-checker swiftlint
    "Swift syntax and style checker"
    :command ("swiftlint"
               "--strict"
               (config-file "--config" flycheck-swiftlintrc)
               "--quiet"
               source)
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ": " "error: " (message) line-end)
      (warning line-start (file-name) ":" line ":" column ": " "warning: " (message) line-end))
    :modes swift-mode)

  (add-to-list 'flycheck-checkers 'swiftlint))

;;(use-package flycheck-rust)

;; (use-package flycheck-gometalinter
;;   :config
;;   (flycheck-gometalinter-setup))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
