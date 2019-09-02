;;; init-hydra --- define hydras to be used with keybindings
;;; Commentary:
;;; Code:



(defhydra hydra-mark
  (:body-pre (call-interactively 'set-mark-command) :exit t)

  "hydra for mark commands"
  ("SPC" er/expand-region)
  ("P" er/mark-inside-pairs)
  ("Q" er/mark-inside-quotes)
  ("p" er/mark-outside-pairs)
  ("q" er/mark-outside-quotes)
  ("d" er/mark-defun)
  ("c" er/mark-comment)
  ("." er/mark-text-sentence)
  ("h" er/mark-text-paragraph)
  ("w" er/mark-word)
  ("u" er/mark-url)
  ("m" er/mark-email)
  ("s" er/mark-symbol)

  ("j" (funcall 'set-mark-command t) :exit nil)
  )



;; (pretty-hydra-define jp-window (:foreign-keys warn :title "Windows Management" :quit-key "q")
;;   ("Actions"
;;    (("TAB" other-window "switch")
;;     ("x" ace-delete-window "delete")
;;     ("m" ace-delete-other-windows "maximize")
;;     ("s" ace-swap-window "swap")
;;     ("a" ace-select-window "select"))

;;    "Resize"
;;    (("h" move-border-left "←")
;;     ("j" move-border-down "↓")
;;     ("k" move-border-up "↑")
;;     ("l" move-border-right "→")
;;     ("n" balance-windows "balance")
;;     ("f" toggle-frame-fullscreen "toggle fullscreen"))

;;    "Split"
;;    (("b" split-window-right "horizontally")
;;     ("B" split-window-horizontally-instead "horizontally instead")
;;     ("v" split-window-below "vertically")
;;     ("V" split-window-vertically-instead "vertically instead"))

;;    "Zoom"
;;    (("+" zoom-in "in")
;;     ("=" zoom-in)
;;     ("-" zoom-out "out")
;;     ("0" jp-zoom-default "reset"))))



(provide 'init-hydra)
;;; init-hydra.el ends here
