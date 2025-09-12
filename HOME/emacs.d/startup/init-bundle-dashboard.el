;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-dashboard --- Configure project features


(use-package dashboard
  :if (startup? 'with-dashboard)
  :config
  ;; (use-package dashboard-project-status
  ;;   :config
  ;;   (add-to-list 'dashboard-item-generators
  ;;                `(project-status . ,(dashboard-project-status "/opt/projects/owlbear")))
  ;;   (add-to-list 'dashboard-items '(project-status) t))
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner startup-banner-file)
  (setq dashboard-banner-logo-title "/A/lways /B/e /C/oding")
  (setq dashboard-set-init-info nil)
  ;; (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-footer nil)
  (setq dashboard-set-navigator t)
  ;; (setq dashboard-footer (shell-command-to-string "fortune -s"))
  (setq dashboard-items
    '((recents   . 10)
       ;; (projects  . 5)
       ;; (project-status . 10)
       (bookmarks . 10)))
  (add-hook 'emacs-startup-hook
    #'(lambda ()
        (switch-to-buffer dashboard-buffer-name)
        (emacs-lock-mode 'kill))))


(provide 'init-bundle-dashboard)
;;; init-bundle-dashboard.el ends here
