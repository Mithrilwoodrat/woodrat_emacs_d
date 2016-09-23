;;; python-config.el --- my python config            -*- lexical-binding: t; -*-

;;; Code:
;;;;;;;;;;
;;python
;;;;;;;;;

;(defun setup-ipython ()
 ; "Setup ipython integration with python-mode"
  ;(interactive)
  ;(setq
   ;python-shell-interpreter "ipython"
   ;python-shell-interpreter-args ""
   ;python-shell-prompt-regexp "In \[[0-9]+\]: "
   ;python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
   ;python-shell-completion-setup-code ""
   ;python-shell-completion-string-code  "';'.join(get_ipython().complete('''%s''')[1])\n"
   ;)
;)

;(add-hook 'python-mode-hook (setup-ipython))
(require 'highlight-indentation)
(defun my-python-hook ()
  (setq python-shell-interpreter "/usr/bin/ipython")
  (setq python-shell-interpreter-args "--simple-prompt -i")
  (setq python-shell-prompt-regexp "In \[[0-9]+\]: "
		python-shell-prompt-output-regexp "Out\[[0-9]+\]: "
		python-shell-completion-setup-code ""
		python-shell-completion-string-code  "';'.join(get_ipython().complete('''%s''')[1])\n"
		)
  (setq python-indent-offset 4)
  (highlight-indentation)
  )
(add-hook 'python-mode-hook 'my-python-hook)


(provide 'python-config)
;;; python-config.el ends here
