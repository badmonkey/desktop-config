;;; init-project --- Configure project features
;;; Commentary:
;;; Code:


(use-package neotree
  :config
  (setq neo-dont-be-alone t
        neo-theme 'nerd)
  (bind-keys :map neotree-mode-map
             ("ESC" . neotree-hide)
             ("u" . neotree-select-up-node)
             ;;("d" . *-neo-down-and-next)
             ("i" . neotree-enter)
             ("K" . neotree-delete-node)))


(use-package projectile
  :diminish
  :init
  (projectile-global-mode)
  :config
  (setq projectile-switch-project-action
		'(lambda ()
		   (venv-projectile-auto-workon)
		   (projectile-dired)))
  (setq projectile-mode-line "Prj"))

(use-package projectile-ripgrep)


(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner "~/.emacs.d/logo.png")
  (setq dashboard-banner-logo-title "Kill all humans")
  (setq dashboard-set-init-info nil)
  ;; (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  ;; (setq dashboard-set-footer nil)
  (setq dashboard-footer (shell-command-to-string "fortune -s"))
  (setq dashboard-items '((recents   . 10)
                          ;; (projects  . 5)
                          (bookmarks . 10))))

(add-hook 'emacs-startup-hook
          '(lambda ()
             (switch-to-buffer dashboard-buffer-name)
             (emacs-lock-mode 'kill)))



(provide 'init-project)
;;; init-project.el ends here
