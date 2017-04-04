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
nnoremap <ESC><ESC>:nohlsearch<CR>

" Perl
au BufNewFile,BufRead cpanfile set filetype=cpanfile
au BufNewFile,BufRead cpanfile set syntax=perl.cpanfile
au BufReadPost,BufNewFile *.t :setl filetype=perl
" autocmd BufNewFile,BufRead *.t nnoremap <F5> :!carton exec -- prove -Ilib %<CR>

autocmd FileType perl PerlLocalLibPath

autocmd BufWinEnter,BufNewFile *.t set filetype=perl.unit
let g:quickrun_config = {}
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 8sp",
\       "outputter/buffer/close_on_empty" : 1,
\       "outputter/buffer/into": 1,
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
nnoremap <F5> :w<CR>:QuickRun<CR>
