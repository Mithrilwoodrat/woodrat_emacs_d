;;; epa.el --- epa config                            -*- lexical-binding: t; -*-

;;; Code:
;;;;gpg
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;
(require 'epa-file)
(add-to-list 'auto-mode-alist '("\\.gpg\\'" . epa-mode-config))

(defun epa-mode-config ()
  (epa-file-enable)
  ;; Using symmetric encryption always
  (setq epa-file-encrypt-to nil)
  ;; save the password
  (setq epa-file-cache-passphrase-for-symmetric-encryption t)
  ;; auto-save
  (setq epa-file-inhibit-auto-save nil))


(provide 'epa-config)
;;; epa.el ends here
