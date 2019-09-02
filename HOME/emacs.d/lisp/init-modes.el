;;; init-modes --- Configure language modes
;;; Commentary:
;;; Code:



(use-package json-mode)

(use-package pandoc-mode)

(use-package yaml-mode
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package dockerfile-mode)

(use-package protobuf-mode
  :config
  (defconst my-protobuf-style
    '((c-basic-offset . 4)
      (indent-tabs-mode . nil)))
  (add-hook 'protobuf-mode-hook
            (lambda ()
              (c-add-style "my-style" my-protobuf-style t))))

(provide 'init-modes)
;;; init-modes.el ends here
