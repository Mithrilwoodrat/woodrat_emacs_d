(global-set-key (kbd "<f5>") 'smart-compile)

(defvar smart-compile-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd "<f5>") 'smart-compile)
    map)
  "Keymap for smart-compile mode")

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

(defun smart-compile-mode ()
   (use-local-map smart-compile-mode-map)
   )
(provide 'smart-compile-mode)
