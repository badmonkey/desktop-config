;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-completion --- Configure lang modes - lua, erlang


(setq ac-auto-show-menu nil)

;; (use-package auto-complete
;;   :init
;;   (require 'auto-complete-config)
;;   :diminish 'auto-complete-mode
;;   :config
;;   (ac-config-default)
;;   (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
;;   (setq ac-modes '(emacs-lisp-mode
;;                     c-mode
;;                     cc-mode
;;                     c++-mode
;;                     python-mode
;;                     lua-mode))
;;   (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict"))

;; (use-package ac-emoji
;;   :config
;;   (add-hook 'markdown-mode-hook 'ac-emoji-setup)
;;   (add-hook 'git-commit-mode-hook 'ac-emoji-setup))


;;(use-package corfu
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
;; :init
;;(global-corfu-mode))

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


(provide 'init-bundle-completion)
;;; init-bundle-completion.el ends here
