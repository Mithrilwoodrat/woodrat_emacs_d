;;; go-config.el --- my go config                    -*- lexical-binding: t; -*-

;;; Code:
;;;;;go mode
(require 'go-mode-autoloads)
(defun go-mode-common-hook ()
  (auto-complete-mode t)
  (setq tab-width 4)
)
(add-hook 'go-mode-hook 'go-mode-common-hook)


(provide 'go-config)
;;; go-config.el ends here
