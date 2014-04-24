" quickrun: outputter/quickfix: Outputs to quickfix.
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

let s:outputter = quickrun#outputter#buffered#new()
let s:outputter.config = {
\   'errorformat': '&l:errorformat',
\ }

function! s:outputter.finish(session)
  try
    let errorformat = &g:errorformat
    let &g:errorformat = self.config.errorformat
    cgetexpr self._result
    cwindow
    for winnr in range(1, winnr('$'))
      if getwinvar(winnr, '&buftype') ==# 'quickfix'
        call setwinvar(winnr, 'quickfix_title', 'quickrun: ' .
        \   join(a:session.commands, ' && '))
        break
      endif
    endfor
  finally
    let &g:errorformat = errorformat
  endtry
endfunction


function! quickrun#outputter#quickfix#new()
  return deepcopy(s:outputter)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo