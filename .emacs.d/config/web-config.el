;;; web-config.el --- my web mode config             -*- lexical-binding: t; -*-

;;; Code:
;;;;;web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 4) ; html element
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)


(provide 'web-config)
;;; web-config.el ends here
