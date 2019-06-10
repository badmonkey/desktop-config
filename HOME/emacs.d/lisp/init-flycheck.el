;;; init-flycheck --- Configure flycheck
;;; Commentary:
;;; Code:


(use-package flycheck
  :diminish 'flycheck-mode
  :config
  (setq-default flycheck-check-syntax-automatically '(save mode-enabled))
  :init
  (setq flycheck-python-pylint-executable "pylint-shim-pylava")
  (setq flycheck-pylintrc "setup.cfg")
  (setq flycheck-indication-mode 'left-fringe)
  (setq flycheck-highlighting-mode 'lines)
  (global-flycheck-mode))

(use-package flycheck-inline
  :load-path contrib-load-path
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-inline-mode))


(provide 'init-flycheck)
;;; init-flycheck.el ends here
