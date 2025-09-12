;;; -*- lexical-binding: t; -*-
;;;
;;; init-mode-misc --- Configure file modes

(add-hook 'nxml-mode
  (lambda ()
    (setq nxml-child-indent 4
      nxml-attribute-indent 4
      nxml-slash-auto-complete-flag t)))


(use-package json-mode)

(use-package pandoc-mode)

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package protobuf-mode
  :config
  (defconst my-protobuf-style
    '((c-basic-offset . 4)
      (indent-tabs-mode . nil)))
  (add-hook 'protobuf-mode-hook
            (lambda ()
              (c-add-style "my-style" my-protobuf-style t))))

(use-package gitlab-ci-mode)



(provide 'init-mode-misc)
;;; init-mode-misc.el ends here
