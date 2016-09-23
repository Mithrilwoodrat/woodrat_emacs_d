;;; c-config.el --- my c config                      -*- lexical-binding: t; -*-
;;; Code:
;;;;;;;
;c/c++
;;;;;;
;;;;我的C++语言编辑策略
;;; clang-complete
(require 'auto-complete-clang-async)  
(defun ac-cc-mode-setup ()  
  (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")  
  (setq ac-sources '(ac-source-clang-async))
  (setq ac-clang-cflags '("-I/usr/include/python2.7/"))
  (ac-clang-launch-completion-process)  
  )  
(defun my-ac-config ()  
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)  
  (global-auto-complete-mode t))  
;(my-ac-config)  
(require 'smart-compile-mode)
(require 'auto-include)

(defun my-c-mode-common-hook ()
  ;(smart-compile-mode) ;; use smart compile
  (auto-include) ; enable auto include mode
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
(add-hook 'c-mode-hook 'my-c-mode-common-hook)

(defun my-c++-mode-hook()
  (auto-include)
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
  ;; (define-key c++-mode-map [f3] 'replace-regexp)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-to-list 'auto-mode-alist (cons "\\.h$" #'c++-mode))


(provide 'c-config)
;;; c-config.el ends here
