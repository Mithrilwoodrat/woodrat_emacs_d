;;; my-c-setting.el ---
(defun auto-include ()
  ;;;cdet
  ;(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
  ;;;;;cedet;;;;;
  ;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;;;;;;;;;;;;;;;;;
  ;(add-to-list 'load-path "~/.emacs.d/plugins/cc-mode/")
  ;(load-file "~/.emacs.d/lisp/cc-mode.el")
  ;(require 'cc-mode)
  ;(c-set-offset 'inline-open 0)
  ;(c-set-offset 'friend '-)
  ;(c-set-offset 'substatement-open 0)
  
;;;;;;;;;;

  ;; 输入 inc , 可以自动提示输入文件名称,可以自动补全.
  ;; Provided by yangyingchao@gmail.com
  (add-to-list 'load-path "~/.emacs.d/plugins/semantic/")
  (require 'semantic)
  (mapc
   (lambda (mode)
     (define-abbrev-table mode '(
				 ("inc" "" skeleton-include 1)
				 )))
   '(c-mode-abbrev-table c++-mode-abbrev-table))
  
  (defconst yc/inc-dir-list
    (append (semantic-gcc-get-include-paths "c++") '("./")) "nil")
  (defvar inc-minibuffer-compl-list nil "nil")
  
  (defun yc/update-minibuffer-complete-table ( )
    "Complete minibuffer"
    (interactive)
    (let ((prompt (minibuffer-prompt))
	  (comp-part (minibuffer-contents-no-properties)))
      (when (and (string= "Include File:" prompt)
		 (> (length comp-part) 0))
	(setq minibuffer-completion-table
	      (append minibuffer-completion-table
		      (let ((inc-files nil)
			    (dirname nil)
			    (tmp-name nil))
			(mapc
			 (lambda (d)
			   (setq dirname (format "%s/%s" d comp-part))
			   (when (file-exists-p dirname)
			     (mapc
			      (lambda (x)
				(when (not (or (string= "." x)
					       (string= ".." x)))
				  (setq tmp-name (format "%s/%s" comp-part x))
				  (add-to-list 'inc-files tmp-name)))
			      (directory-files dirname))))
			 yc/inc-dir-list)
			inc-files)))))
    (insert "/"))
  
  (let ((map minibuffer-local-completion-map))
    (define-key map "/" 'yc/update-minibuffer-complete-table))
  
  (defun yc/update-inc-marks ( )
    "description"
    (let ((statement (buffer-substring-no-properties
                      (point-at-bol) (point-at-eol)))
          (inc-file nil)
          (to-begin nil)
          (to-end nil)
          (yc/re-include
           (rx "#include" (+ ascii) "|XXX|" (group (+ ascii)) "|XXX|")))
      (when (string-match yc/re-include statement)
        (setq inc-file (match-string 1 statement))
        (if (file-exists-p (format "./%s" inc-file))
            (setq to-begin "\"" to-end "\"")
          (setq to-begin "<" to-end ">")
          )
        (move-beginning-of-line 1)
        (kill-line)
        (insert (format "#include %s%s%s" to-begin inc-file to-end))
        (move-end-of-line 1))))
  
  (define-skeleton skeleton-include
    "generate include<>" ""
    > "#include |XXX|"
    (completing-read
     "Include File:"
     (mapcar
      (lambda (f) (list f ))
      (apply
       'append
       (mapcar
	(lambda (dir)
	  (directory-files
	   dir nil
	   "\\(\\.h\\)?"))
	yc/inc-dir-list))))
    "|XXX|"
    (yc/update-inc-marks))
)

(provide 'auto-include)
