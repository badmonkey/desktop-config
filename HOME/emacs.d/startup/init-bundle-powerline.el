;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-powerline --- Config the powerline

;; https://github.com/dbordak/telephone-line
;; https://github.com/dbordak/telephone-line/blob/110c578ccf6c0421cfd9eec7aa3e960b6fd49fb4/examples.org
;; https://github.com/MagicDuck/emacs-config/blob/master/init.el
;; https://quinoa42.github.io/en/dot-emacs/
;; https://github.com/TheBB/spaceline/blob/master/spaceline.el


(use-package eyeliner
  :straight (eyeliner :type git :host github :repo "dustinlacewell/eyeliner")
  :config
  )


(use-package spaceline
  :after eyeliner
  :config

  (spaceline-define-segment segment/python-venvwrap
    "The current python venv, if different from project-name"
    (when (and active
            (eq major-mode 'python-mode)
            (bound-and-true-p venv-current-name))
      (let ((tmp-venv-name (venv-display-name)))
        (if (string= (projectile-project-name) tmp-venv-name)
          "//PROJECT//"
          (propertize (format "//%s//" tmp-venv-name)
            'face 'spaceline-python-venv
            'help-echo (format "Virtual environment: %s" tmp-venv-name))))))

  (spaceline-define-segment segment/projectile
    "Show the current projectile root."
    (when (fboundp 'projectile-project-name)
      (let ((project-name (projectile-project-name)))
        (unless (or (string= project-name "-")
                  (string= project-name (buffer-name)))
          (format "%s:%s" (projectile-project-type) project-name)))))

  (spaceline-define-segment segment/selection
    ""
    (if mark-active
      (if (eq (point) (region-beginning))
        (format "%d < %d" (region-beginning) (region-end))
        (format "%d > %d" (region-beginning) (region-end)))
      (format "%s " (all-the-icons-octicon "pin" :v-adjust 0.1))))

  (spaceline-define-segment segment/icons
    "Show the current icons"
    (format "%s" (subword-icon)))

  )

(use-package spaceline-all-the-icons)

(use-package spaceline-config
  :straight (spaceline :host github :repo "TheBB/spaceline")
  :after eyeliner
  :config
  (setq spaceline-workspace-numbers-unicode t)
  (setq powerline-default-separator 'arrow)
  ;; alternate, arrow, arrow-fade, bar ,box, brace, butt, chamfer
  ;; contour, curve, rounded, roundstub, wave, zigzag
  ;; (setq spaceline-all-the-icons-separator-type 'slant)
  ;; 'slant, 'arrow, 'cup, 'wave, 'none
  (spaceline-toggle-minor-modes-off)
  (spaceline-helm-mode 1)
  (mapc 'eval eyeliner/segment-definitions)

  (spaceline-compile
    'lunaryorn
    ;; Left side of the mode line (all the important stuff)
    ;;
    '(((eyeliner/buffer-modified buffer-size input-method) :face highlight-face)
       '(buffer-id)
       (line-column)
       (all-the-icons-mode-icon segment/icons major-mode)
       (eyeliner/branch-icon eyeliner/branch-name)
       )

    ;; Right segment (the unimportant stuff)
    ;;
    '(((all-the-icons-flycheck-status) :when flycheck-current-errors)
       (all-the-icons-region-info)
       (segment/projectile)
       (segment/python-venvwrap :fallback python-pyvenv)
       ((minor-modes) :when active)
       (all-the-icons-process)
       )
    )
  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-lunaryorn)))
    header-line-format mode-line-format))


(provide 'init-bundle-powerline)
;;; init-bundle-powerline.el ends here
