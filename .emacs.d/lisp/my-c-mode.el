;;; my-c-mode.el ---
(add-to-list 'load-path "~/.emacs.d/plugins/cc-mode/")
(load-file "~/.emacs.d/lisp/cc-mode.el")
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)
(defun my-c-mode-common-hook ()
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
;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
(setq tab-width 4 indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)
(c-set-style "stroustrup")
;; (define-key c++-mode-map [f3] 'replace-regexp)
)
(add-to-list 'auto-mode-alist (cons "\\.h$" #'c++-mode))
;;;;;;;;;;
(global-set-key (kbd "<f5>") 'smart-compile)
(defun smart-compile()
"比较智能的C/C++编译命令
如果当前目录有makefile则用make -k编译，否则，如果是
处于c-mode，就用gcc -Wall编译，如果是c++-mode就用
g++ -Wall编译"
(interactive)
;; 查找 Makefile
(let ((candidate-make-file-name '("makefile" "Makefile" "GNUmakefile"))
      (command nil))
  (if (not (null
	    (find t candidate-make-file-name :key
		  '(lambda (f) (file-readable-p f)))))
      (setq command "make -k ")
;; 没有找到 Makefile ，查看当前 mode 是否是已知的可编译的模式
(if (null (buffer-file-name (current-buffer)))
    (message "Buffer not attached to a file, won't compile!")
  (if (eq major-mode 'c-mode)
      (setq command
	    (concat "gcc -Wall -o "
		    (file-name-sans-extension
		     (file-name-nondirectory buffer-file-name))
		    " "
		    (file-name-nondirectory buffer-file-name)
		    " -g -lm "))
    (if (eq major-mode 'c++-mode)
	(setq command
	      (concat "g++ -Wall -o "
		      (file-name-sans-extension
		       (file-name-nondirectory buffer-file-name))
		      " "
		      (file-name-nondirectory buffer-file-name)
		      " -g -lm -std=c++11"))
      (message "Unknow mode, won't compile!")))))
(if (not (null command))
    (let ((command (read-from-minibuffer "Compile command: " command)))
      (compile command)))))
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

;; 输入 inc , 可以自动提示输入文件名称,可以自动补全.
;; Provided by yangyingchao@gmail.com
(load "semantic-gcc.el")
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
;;;cdet
(load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-semantic-decoration-mode t nil (semantic-decorate-mode))
 '(global-semantic-highlight-edits-mode nil nil (semantic-util-modes))
 '(global-semantic-highlight-func-mode nil nil (semantic-util-modes))
 '(global-semantic-idle-scheduler-mode t nil (semantic-idle))
 '(global-semantic-mru-bookmark-mode t nil (semantic-util-modes))
 '(global-semantic-show-parser-state-mode nil nil (semantic-util-modes))
 '(global-semantic-show-unmatched-syntax-mode nil nil (semantic-util-modes))
 '(global-semantic-stickyfunc-mode nil nil (semantic-util-modes))
 '(global-senator-minor-mode t nil (senator))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(which-function-mode nil))
;(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;;;;;cedet;;;;;
(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
(semantic-load-enable-minimum-features)
;(semantic-load-enable-guady-code-helpers)
;(semantic-load-enable-excessive-code-helpers)
;(semantic-load-enable-semantic-debugging-helpers)
(global-srecode-minor-mode 1)            ; Enable template insertion menu
