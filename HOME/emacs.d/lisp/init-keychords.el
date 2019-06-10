;;; init-keychords --- Custom behaviour
;;; Commentary:
;;; Code:


(use-package key-chord
  :init
  (key-chord-mode 1))


(general-define-key
  (general-chord "[[")   'bm-previous
  (general-chord "]]")   'bm-next
  (general-chord "\\\\") 'bm-annotate-or-create
  (general-chord "{{")   'flycheck-previous-error
  (general-chord "}}")   'flycheck-next-error
  (general-chord "//")   'ac-complete-with-helm
  (general-chord "``")   'switch-to-last-buffer
  (general-chord ";;")   'region-toggle-comment
  (general-chord "==")   'er/expand-region
  (general-chord "++")   'er/contract-region)



(provide 'init-keychords)
;;; init-keychords.el ends here
