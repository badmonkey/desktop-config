;;; -*- lexical-binding: t; -*-
;;;
;;; init-kill-keybinds --- ubind some keybinds


(general-unbind
  ;; So you can't accidently quit or suspend the emacs server
  "C-x C-c"
  "C-z"

  ;; Stop uppercase-region warning from fucking with undo
  "C-x C-u"

  ;; Need to delete this at the source
  "C-x C-b"
  )


(provide 'init-kill-keybinds)
;;; init-kill-keybinds.el ends here
