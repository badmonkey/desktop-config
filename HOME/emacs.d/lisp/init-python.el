;;; init-python --- Configure python
;;; Commentary:
;;; Code:



(use-package python
  :init
  (setq-default python-indent-offset 4)
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt"))

;; (use-package jedi)

(use-package pip-requirements
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(use-package cython-mode
  :mode ("\\.pyd\\'" "\\.pyi\\'" "\\.pyx\\'"))

(use-package python-docstring
  :diminish (python-docstring-mode . " Doc")
  :hook (python-mode . python-docstring-mode))

(use-package pydoc)

(use-package virtualenvwrapper
  :config
  (setq venv-location "/home/mfagan/.virtualenvs/")
  (venv-initialize-interactive-shells) ;; if you want interactive shell support
  (venv-initialize-eshell)) ;; if you want eshell support

(use-package auto-virtualenvwrapper
  :config
  (add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate))

(use-package with-venv
  :config
  (remove-hook 'with-venv-find-venv-dir-functions
          'with-venv-find-venv-dir-poetry)
  (remove-hook 'with-venv-find-venv-dir-functions
          'with-venv-find-venv-dir-pipenv))

(use-package py-pyment
  :load-path contrib-load-path
  :diminish
  :config
  :hook (python-mode . py-pyment-mode)
  :custom
  (py-pyment-options '("--output" "reST")))

(use-package blacken
  :config
  (setq blacken-line-length global-line-max-width)
  (add-hook 'python-mode-hook 'blacken-mode))

(use-package py-isort
  :init
  (setq py-isort-options '("-l 120"))
  (add-hook 'before-save-hook 'py-isort-before-save))


(with-eval-after-load 'flycheck

  (flycheck-def-config-file-var flycheck-pylamarc python-pylama "pylama.ini"
    :safe #'stringp)
  (flycheck-def-config-file-var flycheck-pylavarc python-pylama "pylava.ini"
    :safe #'stringp)
  (flycheck-def-config-file-var flycheck-pylama-setuprc python-pylama "setup.cfg"
    :safe #'stringp)

  (add-hook 'flycheck-before-syntax-check-hook
            (lambda ()
              (setq flycheck-python-pylama-executable (with-venv (executable-find "python")))))


  (flycheck-define-checker python-pylama
    "A Python syntax and style checker using pylama/pylava."
    ;; Not calling pylama/pylava directly makes it easier to switch between different
    ;; Python versions; see https://github.com/flycheck/flycheck/issues/1055.
    :command ("python"
              (eval (flycheck-python-module-args 'python-pylama "pylamashim"))
              (config-file "-o" flycheck-pylamarc)
              (config-file "-o" flycheck-pylavarc)
              (config-file "-o" flycheck-pylama-setuprc)
              ;; Need `source-inplace' for relative imports (e.g. `from .foo
              ;; import bar'), see https://github.com/flycheck/flycheck/issues/280
              source-inplace)
    :error-filter
    (lambda (errors)
      (flycheck-sanitize-errors (flycheck-increment-error-columns errors)))
    :error-patterns
    ((error line-start (file-name) ":" line ":" column ":"
            (or "E" "F") ":"
            (id (one-or-more (not (any ":")))) ":"
            (message) line-end)
     (warning line-start (file-name) ":" line ":" column ":"
              (or "W" "R") ":"
              (id (one-or-more (not (any ":")))) ":"
              (message) line-end)
     (info line-start (file-name) ":" line ":" column ":"
           (or "C" "I") ":"
           (id (one-or-more (not (any ":")))) ":"
           (message) line-end))
    :enabled (lambda ()
               (or (not (flycheck-python-needs-module-p 'python-pylama))
                   (flycheck-python-find-module 'python-pylama "pylamashim")))
    :verify (lambda (_) (flycheck-python-verify-module 'python-pylama "pylamashim"))
    :modes python-mode)

  (add-to-list 'flycheck-checkers 'python-pylama))



(provide 'init-python)
;;; init-python.el ends here
