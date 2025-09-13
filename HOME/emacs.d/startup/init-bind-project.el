;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-project --- Add meta-project bindings


;;; M-p  project commands ;;;
(general-define-key
  :prefix "M-p"
  :prefix-command 'project-keymap

  "TAB"     'helm-recentf

  "RET"     (general-predicate-dispatch 'multi-term-dedicated-toggle
              (derived-mode-p 'python-mode) 'switch-to-python-shell)
  "."       'helm-mini

  "0"       'toggle-window-transparency
  "1"       'toggle-window-dedicated
  "="       'toggle-frame-maximized

  ;; "]"    'flycheck-buffer ??
  "]"       'hydra-flycheck/body
  "["       'hl-todo-occur

  "DEL"     'posframe-delete-all

  ;; "b"    'ibuffer ??

  "d"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'py-pyment-buffer)

  "f"       (general-predicate-dispatch 'helm-find-files
              (projectile-project-p) 'helm-projectile-find-file)
  "F"       (general-predicate-dispatch 'helm-find-files
              (projectile-project-p) 'helm-projectile-find-file-in-known-projects)

  "h"       (general-predicate-dispatch nil
              (derived-mode-p 'python-mode) 'helm-pydoc)

  "g"       'projectile-ripgrep
  "i"       'projectile-project-info
  "k"       'hydra-toggles/body

  "l"       (general-predicate-dispatch nil
              (derived-mode-p 'emacs-lisp-mode) 'load-current-buffer
              (derived-mode-p 'markdown-mode) 'markdown-live-preview-mode)

  "m"       'hydra-magit/body

  "o"       (general-predicate-dispatch 'helm-for-files
              (projectile-project-p) 'helm-projectile)

  "p"       'helm-projectile-switch-project
  "q"       'neotree-toggle
  "r"       'revbufs
  "s"       'ispell
  "t"       'transpose-windows
  "u"       'desktop-save
  "v"       'venv-workon
  "x"       'delete-window

  ;;  helm-buffers-list
  )


(provide 'init-bind-project)
;;; init-bind-project.el ends here
