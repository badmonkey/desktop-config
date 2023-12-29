;;; init-lang --- Configure lang modes - lua, erlang
;;; Commentary:
;;; Code:


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


;; (use-package eglot
;;   :config
;;   (setq eglot-server-programs `()))


(use-package lua-mode
  :mode (("\\.lua\\'" . lua-mode))
  :config
  (setq lua-indent-level 4))


(use-package erlang
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


(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (setq mode-name "λ")
            (setq indent-tabs-mode nil)))


(use-package ponylang-mode
  :config
  (add-hook 'ponylang-mode-hook
            (lambda ()
              (set-variable 'indent-tabs-mode nil)
              (set-variable 'tab-width 4))))

(use-package rust-mode)

(use-package go-mode
  :config
  (add-hook 'before-save-hook 'gofmt-before-save))

(use-package swift-mode)

(use-package zig-mode)

(use-package google-java-format
  :straight (google-java-format :type nil :local-repo "~/.emacs.d/contrib/google-java-format")
  :config
  (add-hook 'java-mode-hook
            (lambda ()
              (setq c-basic-offset 4
                    tab-width 4
                    indent-tabs-mode t)
              (add-hook 'before-save-hook 'google-java-format-buffer nil 'local))))

;;(use-package rust-mode)


(provide 'init-lang)
;;; init-lang.el ends here
