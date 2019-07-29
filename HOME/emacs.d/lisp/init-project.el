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


(provide 'init-project)
;;; init-project.el ends here
