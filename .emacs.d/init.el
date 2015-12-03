(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path' "~/.emacs.d/plugins")
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))
  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))

;;;load configs
(mapc (lambda (config)
	(require config))
      '(settings scheme-config c-config tabbar-config web-config go-config
		 markdown-config python-config epa-config))
	
(require 'popup)





;;;;templete
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory "~/.emacs.d/mytemplates/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(setq auto-insert-alist
      (append '(
            (python-mode . "Template.py")
            )
           auto-insert-alist))
;;;;;w3m
(require 'w3m)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;;;;ibus
;(load-file "~/.emacs.d/ibus/ibus.el")
;(require 'ibus)  
;; 自动开启ibus-mode模式  
;(ibus-mode t)
;(add-hook 'after-init-hook 'ibus-mode-on)  
;(global-set-key (kbd "<C-shift>") 'ibus-toggle) 
 
;asm
(autoload 'nasm-mode "~/.emacs.d/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))
