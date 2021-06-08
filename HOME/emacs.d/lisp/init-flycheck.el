;;; init-flycheck --- Configure flycheck
;;; Commentary:
;;; Code:


(use-package flycheck
  :diminish 'flycheck-mode
  :config
  (setq-default flycheck-check-syntax-automatically '(save mode-enabled))
  :init
  ;; (setq flycheck-python-pylint-executable "pylint-shim-pylava")
  ;; (setq flycheck-pylintrc "setup.cfg")
  (setq flycheck-temp-prefix "__flycheck_")
  (setq flycheck-indication-mode 'left-fringe)
  (setq flycheck-highlighting-mode 'lines)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc python-pylint python-flake8))
  (global-flycheck-mode))


(when (display-graphic-p)
  (use-package flycheck-posframe
    :after flycheck
    :config
    (flycheck-posframe-configure-pretty-defaults)
    ;; frame-center  frame-top-center  window-center
    (setq flycheck-posframe-position 'window-bottom-right-corner)
    (setq flycheck-posframe-border-width 2)
    (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)

    :custom-face
    (flycheck-posframe-border-face ((t (:foreground "DarkRed")))))
)

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
  (flycheck-def-config-file-var flycheck-swiftlintrc flycheck-swiftlint "~/.swiftlink.yml")
  (flycheck-def-executable-var flycheck-swiftlint "/usr/local/bin/swiftlint")

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
