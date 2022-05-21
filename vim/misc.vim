" その他諸々


"inoremap <C-I> <ESC>I
"inoremap <C-A> <ESC>A

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

noremap ;  :
noremap :  ;

" Perl
au BufNewFile,BufRead cpanfile set filetype=cpanfile
au BufNewFile,BufRead cpanfile set syntax=perl.cpanfile
au BufReadPost,BufNewFile *.t :setl filetype=perl
" autocmd BufNewFile,BufRead *.t nnoremap <F5> :!carton exec -- prove -Ilib %<CR>

autocmd FileType perl PerlLocalLibPath

autocmd BufWinEnter,BufNewFile *.t set filetype=perl.unit

if dein#tap('vim-quickrun')
  let s:notify_hook = {}
  let g:quickrun_running_message = ''
  let g:quickrun_notify_success_message = ''
  let g:quickrun_notify_error_message = ''

  function! s:notify_hook.on_ready(session, context) abort
    let g:quickrun_running_message = '[QuickRun] Running'

    if dein#tap('lightline.vim')
      call lightline#update()
    endif
  endfunction

  function! s:notify_hook.on_finish(session, context) abort
    let g:quickrun_running_message = ''

    if dein#tap('lightline.vim')
      call lightline#update()
    endif
  endfunction

  let g:quickrun_config = {}
  let g:quickrun_config = {
  \   "_" : {
  \       "outputter/buffer/bufname": "quickrun://quickrun_output",
  \       "outputter/buffer/close_on_empty" : 1,
  \       "outputter/buffer/into": 0,
  \       "outputter/buffer/running_mark": "Running...",
  \       "outputter/buffer/opener": ":botright 15split",
  \       "runner": "vimproc",
  \       "runner/vimproc/updatetime": 40,
  \       "runner/terminal/opener": "botright 15split",
  \       "hook/output_encode/fileformat": "unix",
  \       "hooks" : [s:notify_hook],
  \   },
  \}

  let g:quickrun_config['perl/carton'] = {
  \   'cmdopt': '-Ilib',
  \   'hook/cd/directory': '%{fnamemodify(finddir(".git", ".;"), ":h")}',
  \   'exec': 'carton exec -- %o perl %s:p %a',
  \}
  let g:quickrun_config['perl.unit'] = {
  \   'cmdopt': '-lrc',
  \   'hook/cd/directory': '%{fnamemodify(finddir(".git", ".;"), ":h")}',
  \   'exec': 'carton exec -- prove %o',
  \   'outputter': 'buffer:filetype=prove-result',
  \}
  let g:quickrun_config['go.test'] = {
  \   'command': 'go',
  \   'exec': '%C test %s | sed s/\\r//',
  \}
  nnoremap <F5> :w<CR>:QuickRun<CR>
endif


function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']
