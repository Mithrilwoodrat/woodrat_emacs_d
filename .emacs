(add-to-list 'load-path "~/.emacs.d/lisp")
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))
(set-language-environment 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq default-direct "/home/woodrat/")
(setq visible-bell 1)
;;;;;;;;;;;;
;;;;;;;;;;;;;;;;
(setq system-uses-terminfo nil)
(setq column-number-mode t)
(setq line-number-mode t) ; 显示行号
(global-linum-mode t)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time) ; 显示时间
(setq make-backup-files nil)

(add-to-list 'load-path' "~/.emacs.d/plugins")

(require 'color-theme)
(load "~/.emacs.d/lisp/color-theme-molokai.el")
(color-theme-molokai)

;;-------------------------------------------------------------
;;Auto complete
;;-------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3.1/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete-1.3.1//ac-dict")
                                        ;(ac-config-default)
                                        ;(add-to-list 'load-path "~/.emacs.d/")
                                        ;(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
;;;;;;;;;;;;
;; Scheme
;;;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "petite") 


;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
	       (get-buffer scheme-buffer)
	       (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
	       (mapcar (lambda (w) (buffer-name (window-buffer w)))
		       (window-list))
	       :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))


(defun scheme-send-last-sexp-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-last-sexp))


(defun scheme-send-definition-split-window ()
  (interactive)
  (scheme-split-window)
  (scheme-send-definition))

;;(add-hook 'scheme-mode-hook
;; (lambda ()
;; (paredit-mode 1)
(define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
(define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)
;;;;;;;
;c/c++
;;;;;;
;;;;我的C++语言编辑策略
;;; clang-complete
(require 'auto-complete-clang-async)  
(defun ac-cc-mode-setup ()  
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")  
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)  
  )  
(defun my-ac-config ()  
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))  
(my-ac-config)  
(require 'smart-compile-mode)
(defun my-c-mode-common-hook ()
  (my-ac-config) ;; use clang-complete
  (smart-compile-mode) ;; use smart compile
  (c-set-style "k&r")
  (setq default-tab-width 4)
  (setq-default indent-tabs-mode nil)
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq c-toggle-auto-newline t)
  (c-toggle-auto-hungry-state 1)
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (setq-default indent-tabs-mode nil)
  (c-set-style "stroustrup")
  ;; (define-key c++-mode-map [f3] 'replace-regexp)
  )
(add-to-list 'auto-mode-alist (cons "\\.h$" #'c++-mode))

;;;;;;;;;;;;;最近文件
(require 'recentf)
(recentf-mode t)
(require 'saveplace)
(require 'savehist)

;;;;;tabbar
(require 'tabbar)

(tabbar-mode t)

(global-set-key (kbd "<M-up>") 'tabbar-backward-group)
(global-set-key (kbd "<M-down>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward-tab)
(global-set-key (kbd "<M-right>") 'tabbar-forward-tab)

(setq
 tabbar-scroll-left-help-function nil ;don't show help information
 tabbar-scroll-right-help-function nil
 tabbar-help-on-tab-function nil
 tabbar-home-help-function nil
 tabbar-buffer-home-button (quote (("") "")) ;don't show tabbar button
 tabbar-scroll-left-button (quote (("") ""))
 tabbar-scroll-right-button (quote (("") "")))


(defun my-tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (list
   (cond
    ((or (get-buffer-process (current-buffer))
	 ;; Check if the major mode derives from `comint-mode' or
	 ;; `compilation-mode'.
	 (tabbar-buffer-mode-derived-p
	  major-mode '(comint-mode compilation-mode)))
     "Process"
     )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "Emacs Buffer"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    (t
     "User Buffer"
     ))))

(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;;;;gpg
;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;
(require 'epa-file)
(epa-file-enable)
;; Using symmetric encryption always
(setq epa-file-encrypt-to nil)
;; save the password
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
;; auto-save
(setq epa-file-inhibit-auto-save nil)
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
;;;;;line highlighting
(global-hl-line-mode t) ;; To enable
(set-face-background 'hl-line "black") ;; change with the color that you like
;;;;;;Highlight Indentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)
;;;Disabling ropemacs
(setq epy-enable-ropemacs nil)
;;;;;;;;;;Markdown mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;;;;;go mode
(require 'go-mode-autoloads)
(defun go-mode-common-hook ()
  (auto-complete-mode t)
)
(add-hook 'go-mode-hook 'go-mode-common-hook)
;;;;;web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
