;;; init-python --- Configure python
;;; Commentary:
;;; Code:


(use-package python
  :init
  (setq-default python-indent-offset 4))

(use-package pip-requirements
  :mode (("\\.pip\\'" . pip-requirements-mode)
         ("requirements.*\\.txt\\'" . pip-requirements-mode)
         ("requirements\\.in" . pip-requirements-mode)))

(use-package cython-mode
  :mode ("\\.pyd\\'" "\\.pyi\\'" "\\.pyx\\'"))

(use-package python-docstring
  :diminish (python-docstring-mode . " Doc")
  :hook (python-mode . python-docstring-mode))

(use-package blacken
  :config
  (setq blacken-line-length '100)
  (add-hook 'python-mode-hook 'blacken-mode))

(use-package py-isort
  :init
  (setq py-isort-options '("--lines=100"))
  (add-hook 'before-save-hook 'py-isort-before-save))

;;(use-package pydoc
;;  :after anaconda-mode
;;  :bind (:map anaconda-mode-map
;;			  ("M-?" . pydoc-at-point)))

(use-package pydoc)

(use-package virtualenvwrapper
  :config
  (setq venv-postactivate-hook
		'(lambda () (message (format "Activating %s" venv-current-name))))
  (setq venv-location "/home/mfagan/.virtualenvs/")
;  (add-hook 'python-mode-hook (lambda () venv-projectile-auto-workon))
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell)) ;; if you want eshell support


(provide 'init-python)
;;; init-python.el ends here
