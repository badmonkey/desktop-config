;;; init-snippets --- expanding snippets
;;; Commentary:
;;; Code:



;; yasnippet
;; (use-package yasnippet
;;   :straight t
;;   :bind
;;   (:map yas-minor-mode-map
;;         ("<tab>" . nil)
;;         ("TAB" . nil))
;;   :hook (yas-before-expand-snippet . expand-for-web-mode)
;;   :config
;;   (yas-global-mode)

;;   )

;; https://github.com/minad/tempel

(use-package aas
  :hook (lisp-mode . aas-activate-for-major-mode)
  :hook (org-mode . aas-activate-for-major-mode)
  :config
  (aas-set-snippets 'lisp-mode
    "use-" "(use-package )")
  (aas-set-snippets 'text-mode
    ;; expand unconditionally
    "o-" "?"
    "i-" "?"
    "a-" "?"
    "u-" "?"
    "e-" "?")
  ;; (aas-set-snippets 'latex-mode
  ;;                   ;; set condition!
  ;;                   :cond #'texmathp ; expand only while in math
  ;;                   "supp" "\\supp"
  ;;                   "On" "O(n)"
  ;;                   "O1" "O(1)"
  ;;                   "Olog" "O(\\log n)"
  ;;                   "Olon" "O(n \\log n)"
  ;;                   ;; bind to functions!
  ;;                   "//" (lambda () (interactive)
  ;;                            (yas-expand-snippet "\\frac{$1}{$2}$0"))
  ;;                   "Span" (lambda () (interactive)
  ;;                            (yas-expand-snippet "\\Span($1)$0")))
  ;; disable snippets by redefining them with a nil expansion
  )




(provide 'init-snippets)
;;; init-snippets.el ends here
