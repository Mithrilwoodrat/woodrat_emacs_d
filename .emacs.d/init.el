
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.e
;; You may delete these explanatory comments.
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;add load paths
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/config")
(add-to-list 'load-path' "~/.emacs.d/plugins")

;;;load configs
(mapc (lambda (config)
	(require config))
      '(settings scheme-config c-config tabbar-config web-config go-config
		 markdown-config python-config epa-config))
	
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
;(require 'w3m)
;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; )
;;;;;ibus
;(load-file "~/.emacs.d/ibus/ibus.el")
;(require 'ibus)  
;; 自动开启ibus-mode模式  
;(ibus-mode t)
;(add-hook 'after-init-hook 'ibus-mode-on)  
;(global-set-key (kbd "<C-shift>") 'ibus-toggle) 

;;yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.\\(yml\\|yaml\\)$" . yaml-mode))

;asm
(autoload 'nasm-mode "~/.emacs.d/nasm-mode.el" "" t)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))

;;;tags
(setq tags-table-list '("~/.emacs.d/"))
(setq path-to-ctags "~/.emacs.d/TAGS") ;; path store TAG
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
  )

;;shell
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "bash")
;(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
;(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
;;multi-term
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
	("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (auto-complete ##))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; input method
;(require 'pyim)
;(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
;(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
;(setq default-input-method "pyim")
;(global-set-key (kbd "C-=") 'toggle-input-method)

;;
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;
(set-face-attribute 'default nil :family "Consolas" :height 110)

;;windows
(set-selection-coding-system 'utf-16-le)

; (setq tramp-default-method "ssh")

