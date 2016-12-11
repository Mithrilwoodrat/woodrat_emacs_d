my_emacs_files
==============

My emacs config files with plugins.
Fast and multiple languages supported.

## Suported Languages
* C/C++  (with auto-complete-clang-async smart-compile header-auto-complete)
* Python (with highlight-indentation)
* Scheme (from cmu-scheme and yinwang's config)
* MarkDown (via markdown-mode)
* Go (via go-mode)
* Web (html js css, via web-mode)

## Required
* guile (for scheme)
* clang and [clang-complete](https://github.com/Golevka/emacs-clang-complete-async) (for auto-complete in c)
* gcc, g++
* ipython (optional, for run python programs)
* etc.

## plugins
plugins are included in `.emacs.d/plugins` and `.emacs.d/lisp`

* a light weight c header file auto-complete mode.

  based on  yangyingchao@gmail.com's sematic include plugin, removed sematic require.
