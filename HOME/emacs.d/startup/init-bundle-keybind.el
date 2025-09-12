;;; -*- lexical-binding: t; -*-
;;;
;;; init-bundle-keybind --- Configure keybinding packages


(use-package general)

(use-package key-chord
  :init
  (key-chord-mode 1))

;;; Hail Hydra!
(use-package hydra
  :config
  (use-package hydra-posframe
    :after posframe
    :straight (:host github :repo "Ladicle/hydra-posframe"
                :fork (:host github :repo "jerrypnz/hydra-posframe"))
    :custom
    (hydra-posframe-parameters
      '((left-fringe . 5)
         (right-fringe . 5)))
    ;; :custom-face
    ;; (hydra-posframe-border-face ((t (:background "#6272a4"))))
    :hook (after-init . hydra-posframe-enable)))

(use-package major-mode-hydra
  :after hydra)


;; (use-package keyfreq
;;   :if (startup? with-keyfreq
;;   :init
;;   (setq keyfreq-excluded-commands
;;         '(self-insert-command
;;           abort-recursive-edit
;;           forward-char
;;           backward-char
;;           left-char
;;           right-char
;;           previous-line
;;           next-line
;;           helm-next-line
;;           helm-previous-line
;;           helm-M-x
;;           newline
;;           proj-open-file
;;           save-buffer
;;           yank))
;;   :config
;;   (setq keyfreq-file (f-join user-emacs-directory "keyfreq.dat"))
;;   (setq keyfreq-file-lock (f-join user-emacs-directory "keyfreq.lock"))
;;   (keyfreq-mode nil)
;;   (keyfreq-autosave-mode 1))


(provide 'init-bundle-keybind)
;;; init-bundle-keybind.el ends here
