" dein.vim
source ~/dotfiles/vim/dein.vim

"基本設定
source ~/dotfiles/vim/basic.vim
"StatusLine設定
source ~/dotfiles/vim/statusline.vim
"インデント設定
source ~/dotfiles/vim/indent.vim
"補完関連
source ~/dotfiles/vim/complete.vim
"検索関連
source ~/dotfiles/vim/search.vim
"移動関連
source ~/dotfiles/vim/moving.vim
"その他
source ~/dotfiles/vim/misc.vim
"プラグインの設定
source ~/dotfiles/vim/plugins_setting.vim

"local
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction
