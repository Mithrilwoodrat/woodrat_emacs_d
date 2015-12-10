;;; c-config.el --- my c config                      -*- lexical-binding: t; -*-

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
;(my-ac-config)  
(require 'smart-compile-mode)
(defun my-c-mode-common-hook ()
  ;(my-ac-config) ;; use clang-complete
  ;(smart-compile-mode) ;; use smart compile
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
  (setq tab-width 4 indent-tabs-mode nil)
  (setq-default indent-tabs-mode nil)
  (c-set-style "stroustrup")
  ;; (define-key c++-mode-map [f3] 'replace-regexp)
  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-to-list 'auto-mode-alist (cons "\\.h$" #'c++-mode))


(provide 'c-config)
;;; c-config.el ends here
