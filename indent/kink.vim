" Vim indent file for Kink
" Language:	Kink (http://code.google.com/p/kink-lang/)
" Maintainer:	Miyakawa Taku <miyakawa.taku@gmail.com>
" Last Change:  2014-10-12

" Copyright (c) 2014 Miyakawa Taku
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

" Loads the script when no other was loaded
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Basic settings
setlocal nolisp
setlocal autoindent

setlocal indentexpr=GetKinkIndent(v:lnum)
setlocal indentkeys=0},0),0=],0=*),0=*],!^F,o,O

" Defines the function only once.
if exists("*GetKinkIndent")
  finish
endif

let s:save_cpo = &cpo
set cpo&vim

" Returns the indent
function! GetKinkIndent(line_number)
  " No indent in a string
  if has('syntax_items') && synIDattr(synID(a:line_number, 0, 1), "name") =~ "String"
    return -1
  endif

  " Previous non empty line
  let prev_line_number = prevnonblank(a:line_number - 1)
  if prev_line_number == 0
    return 0
  endif

  let prev_indent = indent(prev_line_number)
  let skip = 'has("syntax_items") && synIDattr(synID(line("."), col("."), 1), "name") =~ "String\\|Comment"'

  " Closing a paren/brace/brancket?
  let cur_line = getline(a:line_number)
  if cur_line =~ '^\s*\(}\|\*\?]\|\*\?)\)'
    let opening_pattern = (cur_line =~ '^\s*}' ? '{' : cur_line =~ '^\s*\*\?]' ? '\[' : '(')
    let closing_pattern = (opening_pattern == '{' ? '}' : opening_pattern == '\[' ? ']' : ')')
    call cursor(a:line_number, 1)
    let open_line_number = searchpair(opening_pattern, '', closing_pattern, 'bnW', skip)
    return (open_line_number > 0 ? indent(open_line_number) : prev_indent)
  endif

  " Opening a paren/brace/brancket?
  call cursor(prev_line_number, 1)
  let search_option =  'cW'
  while search('{\|\[\|(', search_option, prev_line_number) > 0
    let search_option = 'W'
    if has('syntax_items') && synIDattr(synID(prev_line_number, col('.'), 1), "name") =~ 'String\|Comment'
      continue
    endif
    let opening = getline(line('.'))[col('.') - 1]
    let opening_pattern = (opening == '[' ? '\[' : opening)
    let closing_pattern = (opening == '{' ? '}' : opening == '[' ? ']' : ')')
    if searchpair(opening_pattern, '', closing_pattern, 'W', skip) != prev_line_number
      return prev_indent + &shiftwidth
    endif
  endwhile

  return prev_indent

endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: et sw=2 sts=2
