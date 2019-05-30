;;; init-misc-modes --- Configure minor modes
;;; Commentary:
;;; Code:


(use-package diminish
  :config
  (progn (add-hook 'whitespace-mode-hook (lambda () (diminish 'whitespace-mode)))))

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
            (lambda () (c-add-style "my-style" my-protobuf-style t))))

(use-package markdown-mode
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config)

(use-package rst
  :config
  (add-hook 'rst-mode-hook
            (lambda ()
              (local-set-key (kbd "C-M-h") 'backward-kill-word)
              (setq-local fill-column 80)
              (turn-on-auto-fill))))


(provide 'init-misc-modes)
;;; init-misc-modes.el ends here
