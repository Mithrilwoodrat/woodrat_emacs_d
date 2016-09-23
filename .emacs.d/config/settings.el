;;; settings.el --- my emacs settings                -*- lexical-binding: t; -*-

;;; Code:

(set-language-environment 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;(setq default-direct "/home/woodrat/")
(setq visible-bell 1)
(setq default-tab-width 4)
;;;;;;;;;;;;
;(setq system-uses-terminfo nil)) ;; this will make compilation output messy
;;;add shell hook because of color set in zsh does not work in emacs
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;this does not work,use ansi-term instead!
;;;;
(setq column-number-mode t)
(setq line-number-mode t) ; 显示行号
(global-linum-mode t)
(show-paren-mode t)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time) ; 显示时间
(setq make-backup-files nil)

(require 'color-theme)
;(load "~/.emacs.d/lisp/color-theme-molokai.el")
;(color-theme-molokai)
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow-eighties)

;;highlight indentation
(require 'highlight-indentation)
(set-face-background 'highlight-indent-face "#696969")

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

;;;;;;;;;;;;;最近文件
(require 'recentf)
(recentf-mode t)
(require 'saveplace)
(require 'savehist)


(provide 'settings)
;;; settings.el ends here
