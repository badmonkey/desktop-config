;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-misc --- Add general bindings


(general-define-key
  :prefix "ESC"
  "ESC" 'keyboard-quit
  )


(general-define-key
  "<f5>"            'projectile-compile-project
  "<backtab>"       'region-indent-left

  "<home>"          'crux-move-beginning-of-line
  "<end>"           'move-end-of-line
  )


(provide 'init-bind-misc)
;;; init-bind-misc.el ends here
