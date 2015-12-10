my_emacs_files
==============

my emacs config files with plugins.
fast, and multiple languages supported.

I'm using cdet with sematic before, but it's too heavy, so I removed it.

## Suported Language
* C/C++  (with auto-complete-clang-async and smart-compile)
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

## TODO
* make a light c header file auto-complete mode.

base yangyingchao@gmail.com's sematic include plugin, remove sematic require.

now just return a simple path, could do more path search in the future.

see [auto-include.el](.emacs.d/lisp/auto-include.el) for more info.
