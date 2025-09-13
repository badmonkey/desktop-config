;;; -*- lexical-binding: t; -*-
;;;
;;; init-ifun-python --- interactive funs for python


(defun activate-venv ()
  (interactive)
  (venv-projectile-auto-workon))


(defun switch-to-python-shell ()
  (interactive)
  (unless (python-shell-get-process)
    (run-python))
  (python-shell-switch-to-shell))


(defun venv-display-name ()
  (interactive)
  (when (bound-and-true-p venv-current-name)
    (let ((tmp-venv-name (file-truename venv-current-name)))
      (if (file-directory-p tmp-venv-name)
        (venv-dir-to-name tmp-venv-name)
        venv-current-name))))


(provide 'init-ifun-python)
;;; init-ifun-python.el ends here
