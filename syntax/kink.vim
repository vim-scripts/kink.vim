" Vim syntax file
" Language:	Kink (http://code.google.com/p/kink-lang/)
" Maintainer:	Miyakawa Taku <miyakawa.taku@gmail.com>
" Last Change:	2013-05-26

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

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

syntax match kinkVerb "[a-z][a-zA-Z_0-9?]*"
syntax match kinkNoun "[A-Z_][a-zA-Z_0-9?]*"
syntax keyword kinkTodo contained TODO FIXME XXX
syntax match kinkComment "#.*" contains=kinkTodo
syntax region kinkString start=+%\?'+ skip=+''+ end=+'+
syntax region kinkString start=+%\?"+ skip=+\\.+ end=+"+ contains=kinkStringEscape
syntax match kinkStringEscape contained +\\[0tnrabefv"\\]\|\\u[0-9a-f]\{4}\|\\U[0-9a-f]\{6}+
syntax match kinkPseudoVariable "\\\(env\|recv\|args\|[0-9][0-9_]*\|0x[0-9a-f_]*\|0b[01_]*\)\>"
syntax match kinkInteger "0x[0-9a-f_]*\|0b[01_]*\|[0-9][0-9_]*"
syntax match kinkDecimal "[0-9][0-9_]*\.[0-9][0-9_]*"

" Define the default highlighting.
highlight default link kinkNoun Identifier
highlight default link kinkComment Comment
highlight default link kinkTodo Todo
highlight default link kinkString String
highlight default link kinkStringEscape SpecialChar
highlight default link kinkPseudoVariable Special
highlight default link kinkInteger Number
highlight default link kinkDecimal Float

let b:current_syntax = "kink"

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sw=2 sts=2
