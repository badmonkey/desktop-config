;;; -*- lexical-binding: t; -*-
;;;
;;; init-lang-misc --- Configure minor langs


;;;;;;;; rust ;;;;;;;;
(use-package rust-mode
  :if (startup? 'with-rust))

;;(use-package flycheck-rust)


;;;;;;;; go ;;;;;;;;
(use-package go-mode
  :if (startup? 'with-go)
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

;; (use-package flycheck-gometalinter
;;   :config
;;   (flycheck-gometalinter-setup))


;;;;;;;; zig ;;;;;;;;
(use-package zig-mode
  :if (startup? 'with-zig))


;;;;;;;; pony ;;;;;;;;
(use-package ponylang-mode
  :if (startup? 'with-pony)
  :config
  (add-hook 'ponylang-mode-hook
    (lambda ()
      (set-variable 'indent-tabs-mode nil)
      (set-variable 'tab-width 4))))

(use-package flycheck-pony
  :after (flycheck ponylang-mode)
  :if (startup? 'with-flycheck 'with-pony))


;;;;;;;; erlang ;;;;;;;;
(use-package erlang
  :if (startup? 'with-erlang)
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


(provide 'init-lang-misc)
;;; init-lang.el ends here
