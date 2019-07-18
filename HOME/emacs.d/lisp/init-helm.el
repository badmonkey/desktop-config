;;; init-helm --- Configure helm
;;; Commentary:
;;; Code:


;; (use-package ido
;;   :config
;;   (setq ido-enable-flex-matching t)
;;   (ido-everywhere t)
;;   (ido-mode 1))


(use-package helm
  :diminish helm-mode
  :bind (("M-a" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ;("C-SPC" . helm-dabbrev)
         ("M-y" . helm-show-kill-ring)
         ("C-h i" . 'helm-info-at-point)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
         ("M-i" . helm-previous-line)
         ("M-k" . helm-next-line)
         ("M-I" . helm-previous-page)
         ("M-K" . helm-next-page)
         ("M-h" . helm-beginning-of-buffer)
         ("M-H" . helm-end-of-buffer))
  :config (progn
         (setq helm-split-window-in-side-p           t
			   helm-move-to-line-cycle-in-source     t
			   helm-ff-search-library-in-sexp        t
			   helm-scroll-amount                    8
			   helm-ff-file-name-history-use-recentf t
			   helm-move-to-line-cycle-in-source     t
			   helm-prevent-escaping-from-minibuffer t
			   helm-bookmark-show-location           t)
		 (helm-mode 1)
		 (helm-adaptive-mode 1))
  )

(use-package helm-projectile
  :config
  (helm-projectile-on))

(use-package helm-pydoc
  :config)

(use-package bm
  :init
  (setq bm-restore-repository-on-load t)

  :config
  (setq bm-highlight-style 'bm-highlight-only-fringe)
  (setq bm-marker 'bm-marker-left)

  (setq bm-cycle-all-buffers t)
  (setq bm-repository-file "~/.emacs.d/bookmarks")
  (setq-default bm-buffer-persistence t)

  (add-hook 'after-init-hook 'bm-repository-load)

  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  (add-hook 'after-save-hook #'bm-buffer-save)

  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore))

(use-package helm-bm)

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


(provide 'init-helm)
;;; init-helm.el ends here
