;;; scheme-config.el --- my scheme configs           -*- lexical-binding: t; -*-

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
;;;;;;;;;;;;
;; Scheme
;;;;;;;;;;;;

(require 'cmuscheme)
(setq scheme-program-name "guile") 
;(setq scheme-program-name "petite") 


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

(defun my-scheme-mode-hook ()
  (show-paren-mode t))

(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)

(provide 'scheme-config)
;;; scheme-config.el ends here