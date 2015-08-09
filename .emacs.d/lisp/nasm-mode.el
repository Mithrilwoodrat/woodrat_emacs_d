;;; This is my emacs mode for coding assembly language that works 
;;; with the nasm assembler. I originally wrote it to overcome
;;; some of the things I didn't like in nasm-mode.

;;; It's licensed under the Gnu General Public License, NO WARRANTY.


(defvar nasm-mode-hook () "Hook run when starting nasm-mode.")
(defvar nasm-mode-map () "Map used by nasm-mode.")
(defvar nasm-mode-syntax-table () "Nasm-mode's syntax table.")

(if (null nasm-mode-map)
    (progn
      (setq nasm-mode-map (make-sparse-keymap))
      ))

(define-key nasm-mode-map "\C-i" 'tab-to-tab-stop)
(define-key nasm-mode-map "\C-j" 'nasm-newline)
(define-key nasm-mode-map "\C-m" 'nasm-newline)
(define-key nasm-mode-map ";" 'nasm-semicolon)
(define-key nasm-mode-map ":" 'nasm-colon)
(define-key nasm-mode-map "," 'nasm-comma)

(setq nasm-mode-syntax-table (make-syntax-table))
(modify-syntax-entry ?\; "<" nasm-mode-syntax-table)
(modify-syntax-entry ?\n ">" nasm-mode-syntax-table)
(modify-syntax-entry ?\" "\"" nasm-mode-syntax-table)
(modify-syntax-entry ?' "\"" nasm-mode-syntax-table)


(defconst nasm-font-lock-keywords
  (list
   '("^\\(\\w+\\):"                  (1 font-lock-function-name-face))
   '("^\\(\\w+:\\)?[ \t]+\\(\\w+\\)" (2 font-lock-keyword-face t))
   '("\\<\\(times\\)[ \t]+[^ \t\n]+[ \t]+\\(\\w+\\)\\>"
     (1 font-lock-keyword-face t)
     (2 font-lock-keyword-face t))
   '(";.*$"                          . font-lock-comment-face)
   '("\\<[abcd]h\\>"                 . font-lock-variable-name-face)
   '("\\<[abcd]l\\>"                 . font-lock-variable-name-face)
   '("\\<e?[abcd]x\\>"               . font-lock-variable-name-face)
   '("\\<[cdefg]s\\>"                . font-lock-variable-name-face)
   '("\\<[ds]i\\>"                   . font-lock-variable-name-face)
   '("\\<[bs]p\\>"                   . font-lock-variable-name-face)
   '("\\<[cdefg]s\\>"                . font-lock-variable-name-face)
   '("\\<edi\\>"                     . font-lock-variable-name-face)
   '("\\<\\(byte\\|d?word\\)\\>"     . font-lock-type-face)
   '("^\\(\\w+\\)[ \t]+\\(db\\|equ\\)\\>"
     (1 font-lock-variable-name-face t)
     (2 font-lock-keyword-face t))
   ))

;; (put 'nasm-mode 'font-lock-defaults
;;      '((nasm-font-lock-keywords) nil nil nil nil))


;;;###autoload
(defun nasm-mode ()
  "Major mode for editing nasm assembler source code. It's essentially
a pared-down version of asm-mode, customized by Tom.

\\{nasm-mode-map}"


  (interactive)
  (kill-all-local-variables)

  (setq mode-name "Nasm")
  (setq major-mode 'nasm-mode)
  (setq comment-start ";")
  (set-syntax-table nasm-mode-syntax-table)

  (make-local-variable 'font-lock-defaults)
  (setq font-lock-defaults
        '((nasm-font-lock-keywords) nil nil nil nil))

  (run-hooks 'nasm-mode-hook)
  (use-local-map nasm-mode-map)
  )


(defun nasm-newline ()
  "Inserts linefeed, and then indents to the appropriate point on the 
next time."
  (interactive)
  (if (eolp) (delete-horizontal-space))
  (insert "\n")
  (indent-relative)
  )
(defun nasm-simple-newline ()
    (interactive)
  (if (eolp) (delete-horizontal-space))
  (insert "\n")
  )
(defun nasm-comma ()
 "if comma insert space"  
 (interactive)
  (insert ", ")
  )
(defun nasm-semicolon ()
  "Inserts a semicolon in the current buffer, indenting to the next tab
stop if we're not currently at a tab stop."
  (interactive)
  (unless (member (current-column) tab-stop-list)
    (tab-to-tab-stop)
    )
  (insert "; ")
  )

(defun nasm-colon ()
  "Handles colons... If it's a label, pushes it to the start of the line,
otherwise just inserts it."
  (interactive)

  (if
      (save-excursion
        (beginning-of-line)
        (looking-at "[ \t]+\\.*\\sw+$"))
      (progn
        (beginning-of-line)
        (delete-horizontal-space)
        (end-of-line)
        (insert ":")
        (tab-to-tab-stop)
        )
    (insert ":")
    )
  )


;; (setq auto-mode-alist (cons '("\\.asm$" . nasm-mode) auto-mode-alist))

(provide 'nasm-mode)


