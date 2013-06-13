" Vim filetype detection file
" Language:	Kink (http://code.google.com/p/kink-lang/)
" Maintainer:	Miyakawa Taku <miyakawa.taku@gmail.com>
" Last Change:  2013-06-13

" Copyright (c) 2013 Miyakawa Taku
" 
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
" 
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
" 
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

let s:save_cpo = &cpo
set cpo&vim

autocmd BufRead,BufNewFile * silent call s:DetectKink()

function s:DetectKink()
  if expand('%') =~ '\.kn$' || getline(1) =~ '#!.*\<kink\>'
    setlocal filetype=kink
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sw=2 sts=2
