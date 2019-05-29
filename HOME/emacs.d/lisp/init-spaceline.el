;;; init-spaceline --- Config spaceline
;;; Commentary:
;;; Code:


(use-package spaceline
  :config
  (progn
	(spaceline-define-segment python-venvwrap
	  "The current python venv."
	  (when (and active
				 (bound-and-true-p venv-current-name))
		(propertize (format "<%s>" venv-current-name)
					'face 'spaceline-python-venv
					'help-echo (format "Virtual environment: %s"
									   venv-current-name))))
	(spaceline-define-segment projectile-root
	  "Show the current projectile root."
	  (when (fboundp 'projectile-project-name)
		(let ((project-name (projectile-project-name)))
		  (unless (or (string= project-name "-")
					  (string= project-name (buffer-name)))
			(format "/%s/" project-name)))))
   ))


(use-package all-the-icons)

(use-package spaceline-config
  :ensure spaceline
  :config
  (spaceline-compile
   'lunaryorn
   ;; Left side of the mode line (all the important stuff)
   '(((buffer-modified buffer-size input-method) :face highlight-face)
     '(buffer-id remote-host buffer-encoding-abbrev)
     ((point-position line-column buffer-position selection-info) :separator " | ")
     major-mode
     process
     (flycheck-error flycheck-warning flycheck-info)
     (python-venvwrap :fallback python-pyvenv)
     projectile-root
     ((minor-modes :separator spaceline-minor-modes-separator) :when active))
   ;; Right segment (the unimportant stuff)
   '((version-control :when active)))
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-lunaryorn)))
                header-line-format mode-line-format))

;(use-package spaceline-all-the-icons
;  :after spaceline
;  :config (spaceline-all-the-icons-theme))



(provide 'init-spaceline)
;;; init-spaceline.el ends here
