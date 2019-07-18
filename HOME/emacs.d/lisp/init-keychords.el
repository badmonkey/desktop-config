;;; init-keychords --- Custom behaviour
;;; Commentary:
;;; Code:


;; (general-define-key
;;   "H-p"	'point-to-buffer-start)


(general-define-key
  (general-chord ";;")   'region-toggle-comment

  (general-chord "\\\\") 'bm-toggle

    ;; (general-chord "==")   'er/expand-region
  (general-chord "++")   'er/contract-region
  (general-chord "``")   'point-to-buffer-start

  (general-chord "[;")   'previous-error
  (general-chord ";[")   'previous-error
  (general-chord "];")   'next-error
  (general-chord ";]")   'next-error

  (general-chord "[\\")   'bm-previous
  (general-chord "\\[")   'bm-previous
  (general-chord "]\\")   'bm-next
  (general-chord "\\]")   'bm-next
  )


(general-define-key
  :prefix "H-f"
  :prefix-command 'extra-chords-keymap

  (general-chord "==")   'er/expand-region
  )



;; (key-chord-define-global "0o" ")")
;; ;; Sadly, "1q" is impossible to hit on my keyboard.
;; (key-chord-define-global "1q" "!")
;; (key-chord-define-global "2w" "@")
;; (key-chord-define-global "3e" "#")
;; (key-chord-define-global "4r" "$")
;; (key-chord-define-global "5t" "%")
;; (key-chord-define-global "6y" "^")
;; (key-chord-define-global "6t" "^")
;; (key-chord-define-global "7y" "&")
;; (key-chord-define-global "8u" "*")
;; (key-chord-define-global "9i" "(")
;; (key-chord-define-global "-p" "_")

;; (key-chord-define emacs-lisp-mode-map
;;                   "7y" "&optional ")



(provide 'init-keychords)
;;; init-keychords.el ends here
