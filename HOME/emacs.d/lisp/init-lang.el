;;; ...  -*- lexical-binding: t -*-
;;;
;;; init-lang --- Configure lang modes - lua, erlang


(use-package corfu
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
  ;; (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
  ;; (corfu-quit-no-match t)        ;; Automatically quit if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (global-corfu-mode))

;; (use-package corfu
;;   :custom
;;   (corfu-cycle t)
;;   :init
;;   (global-corfu-mode)
;;   :config
;;   (with-eval-after-load 'savehist
;;     (corfu-history-mode 1)
;;     (add-to-list 'savehist-additional-variables 'corfu-history)))


;; (use-package eglot
;;   :config
;;   (setq eglot-server-programs `()))

;; (use-package eglot
;;   :ensure nil
;;   :custom
;;   (eldoc-echo-area-use-multiline-p nil)
;;   (completion-category-defaults nil)
;;   :config
;;   (push '(rustic-ts-mode . eglot-rust-analyzer) eglot-server-programs)
;;   (add-to-list 'eglot-server-programs
;;     '((rust-mode rustic-ts-mode)
;;        . (eglot-rust-analyzer "rust-analyzer")))
;;   :bind (:map eglot-mode-map
;;           ("M-(" . flymake-goto-next-error)
;;           ("C-c ," . eglot-code-actions)))

;; (use-package breadcrumb
;;   :ensure (:host github :repo "joaotavora/breadcrumb")
;;   :config (breadcrumb-mode))


;;;;;;;; elisp ;;;;;;;;

(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (setq mode-name "λ")
    (setq indent-tabs-mode nil)))


;;;;;;;; python ;;;;;;;;

(when (startup-lang "python")
  (require 'init-python))


;;;;;;;; lua ;;;;;;;;

(use-package lua-mode
  :mode (("\\.lua\\'" . lua-mode))
  :config
  (setq lua-indent-nested-block-content-align nil)
  (setq lua-indent-close-paren-align nil)
  (setq lua-indent-level 2)
  )


;;;;;;;; erlang ;;;;;;;;

(use-package erlang
  :if (startup-lang "erlang")
  :init
  :mode (("\\.erl\\'" . erlang-mode)
          ("\\.hrl\\'" . erlang-mode)
          ("\\.xrl\\'" . erlang-mode)
          ("sys\\.config\\'" . erlang-mode)
          ("rebar\\.config\\'" . erlang-mode)
          ("\\.app\\(\\.src\\)?\\'" . erlang-mode))
  :config
  (setq erlang-indent-level 4)
  (add-hook 'erlang-mode-hook
    (lambda ()
      (setq mode-name "erl" erlang-compile-extra-opts '((i . "../include"))
        erlang-root-dir "/usr/local/lib/erlang"))))


;;;;;;;; pony ;;;;;;;;

(use-package ponylang-mode
  :if (startup-lang "pony")
  :config
  (add-hook 'ponylang-mode-hook
    (lambda ()
      (set-variable 'indent-tabs-mode nil)
      (set-variable 'tab-width 4))))

(use-package flycheck-pony
  :after (flycheck ponylang-mode)
  :if (startup-lang "pony"))


;;;;;;;; rust ;;;;;;;;

(use-package rust-mode
  :if (startup-lang "rust"))

;;(use-package flycheck-rust)


;;;;;;;; go ;;;;;;;;

(use-package go-mode
  :if (startup-lang "go")
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

;; (use-package flycheck-gometalinter
;;   :config
;;   (flycheck-gometalinter-setup))


;;;;;;;; swift ;;;;;;;;

(use-package swift-mode)

(use-package flycheck-swift
  :after (flycheck swift-mode)
  :config
  (flycheck-swift-setup))

(with-eval-after-load 'flycheck
  (with-eval-after-load 'flycheck-swift
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

    (add-to-list 'flycheck-checkers 'swiftlint)))

;; (use-package flycheck-swiftlint
;;   :after flycheck
;;   :config
;;   (flycheck-swiftlint-setup))


;;;;;;;; zig ;;;;;;;;

(use-package zig-mode
  :if (startup-lang "zig"))


;;;;;;;; java ;;;;;;;;

(use-package google-java-format
  :if (startup-lang "java")
  :straight (google-java-format
              :type nil
              :local-repo (expand-file-name "google-java-format" user-sitelisp-directory))
  :config
  (add-hook 'java-mode-hook
    (lambda ()
      (setq c-basic-offset 4
        tab-width 4
        indent-tabs-mode t)
      (add-hook 'before-save-hook 'google-java-format-buffer nil 'local))))


(provide 'init-lang)
;;; init-lang.el ends here
