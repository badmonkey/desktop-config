;;; -*- lexical-binding: t; -*-
;;;
;;; init-lang-swift --- Configure swift lang


(use-package swift-mode)

(use-package flycheck-swift
  :after (flycheck swift-mode)
  :config
  (flycheck-swift-setup))

(with-eval-after-load 'flycheck
  (with-eval-after-load 'flycheck-swift
    (flycheck-def-config-file-var flycheck-swiftlintrc swiftlink ".swiftlint.yml")
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

    (add-to-list 'flycheck-checkers 'swiftlint)))

;; (use-package flycheck-swiftlint
;;   :after flycheck
;;   :config
;;   (flycheck-swiftlint-setup))


(provide 'init-lang-swift)
;;; init-lang-swift.el ends here
