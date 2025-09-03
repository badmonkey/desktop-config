;;; -*- lexical-binding: t; -*-
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
  (setq-default flycheck-disabled-checkers
    (-union
      '(emacs-lisp-checkdoc python-pylint python-flake8 python-mypy)
      (if (startup-when "elisp-lint") `() `(emacs-lisp))))
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

;; (use-package flycheck-indicator
;;   :hook (flycheck-mode . flycheck-indicator-mode))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
