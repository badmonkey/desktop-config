;;; init-helm --- Configure helm
;;; Commentary:
;;; Code:


(use-package helm
  :diminish helm-mode
  :config
  (setq helm-split-window-in-side-p           t
        helm-move-to-line-cycle-in-source     t
        helm-ff-search-library-in-sexp        t
        helm-scroll-amount                    8
        helm-ff-file-name-history-use-recentf t
        helm-move-to-line-cycle-in-source     t
        helm-prevent-escaping-from-minibuffer t
        helm-bookmark-show-location           t)
  (helm-mode 1)
  (helm-adaptive-mode 1)
  )

(use-package helm-posframe
  :after helm
  :custom-face
  (helm-posframe-border ((t (:background "#b58900"))))
  :custom
  (helm-posframe-border-width 3)
  (helm-posframe-parameters '((left-fringe . 10)
                              (right-fringe . 10)))
  :config
  (setq helm-posframe-poshandler
        'posframe-poshandler-frame-center
        helm-posframe-height (frame-height)
        helm-posframe-width (frame-width))
  (helm-posframe-enable)
  (remove-hook 'delete-frame-functions 'helm--delete-frame-function))

(use-package helm-projectile
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

(use-package helm-pydoc
  :config)

(use-package helm-google)

(use-package helm-bm)

;; (use-package helm-unicode)

(use-package helm-dash
  :init
  (defun c-doc ()
    (setq helm-dash-docsets '("C")))
  (defun c++-doc ()
    (setq helm-dash-docsets '("C" "C++")))
  (add-hook 'c-mode-hook 'c-doc)
  (add-hook 'c++-mode-hook 'c++-doc))

(use-package swiper-helm)

(use-package ac-helm)

(use-package helm-rg)

(use-package ggtags)

(use-package imenu-anywhere)


(provide 'init-helm)
;;; init-helm.el ends here
