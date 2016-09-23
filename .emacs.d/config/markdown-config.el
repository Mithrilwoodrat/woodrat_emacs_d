;;; markdown-config.el --- my markdown config        -*- lexical-binding: t; -*-

;;; Code:
;;;;;;;;;;Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun my-markdown-config ()
  (setq markdown-command "markdown_py")
  ;unbind tabbar keys
  (define-key markdown-mode-map (kbd "M-<up>") nil)
  (define-key markdown-mode-map (kbd "M-<down>") nil)
  (define-key markdown-mode-map (kbd "M-<left>") nil)
  (define-key markdown-mode-map (kbd "M-<right>") nil))
 
(add-hook 'markdown-mode-hook 'my-markdown-config)

(provide 'markdown-config)
;;; markdown-config.el ends here
