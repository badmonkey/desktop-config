;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-flycheck --- Configure flycheck


(when (startup? 'with-flycheck)
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
    (setq-default flycheck-disabled-checkers
      (-union
        '(emacs-lisp-checkdoc python-pylint python-flake8 python-mypy)
        (unless (startup? 'with-elisp-lint) `(emacs-lisp))))
    (global-flycheck-mode))
  )

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

;; (use-package flycheck-indicator
;;   :hook (flycheck-mode . flycheck-indicator-mode))

;; https://github.com/konrad1977/flyover/tree/1a3ca187d4ce8ce6d603748b88a40881e140bb1a


(provide 'init-bundle-flycheck)
;;; init-bundle-flycheck.el ends here
