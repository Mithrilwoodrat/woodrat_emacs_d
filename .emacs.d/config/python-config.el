;;; python-config.el --- my python config            -*- lexical-binding: t; -*-

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
(defun my-python-hook ()
  (setq show-paren-mode t))

;;;;;line highlighting
(global-hl-line-mode t) ;; To enable
(set-face-background 'hl-line "black") ;; change with the color that you like
;;;;;;Highlight Indentation
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)
;;;Disabling ropemacs
;(setq epy-enable-ropemacs nil)


(provide 'python-config)
;;; python-config.el ends here
