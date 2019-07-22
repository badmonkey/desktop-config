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



(provide 'init-hydra)
;;; init-hydra.el ends here
