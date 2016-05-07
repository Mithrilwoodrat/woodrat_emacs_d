;;; settings.el --- my emacs settings                -*- lexical-binding: t; -*-

;; Copyright (C) 2015  

;; Author:  <woodrat@work-pc.research.keen>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(set-language-environment 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
;(setq default-direct "/home/woodrat/")
(setq visible-bell 1)
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

;;;;;;;;;;;;;最近文件
(require 'recentf)
(recentf-mode t)
(require 'saveplace)
(require 'savehist)


(provide 'settings)
;;; settings.el ends here
