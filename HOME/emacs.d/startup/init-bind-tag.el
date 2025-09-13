;;; -*- lexical-binding: t; -*-
;;;
;;; init-bind-tag --- Add meta-tag bindings


;;; M-t tag commands ;;;
(general-define-key
  :prefix "M-t"

  "."       'ggtags-find-tag-dwim
  "TAB"     'ggtags-view-search-history

  "c"       'ggtags-create-tags
  "d"       'ggtags-find-definition
  "o"       'imenu-anywhere
  "r"       'ggtags-query-replace
  "u"       'ggtags-update-tags
  "x"       'ggtags-explain-tags
  )


(provide 'init-bind-tag)
;;; init-bind-tag.el ends here
