let mapleader = ","               " キーマップリーダ
set textwidth=0                 " 一行に長い文章を書いていても自動折り返しをしない
set backupdir=~/dotfiles/vim/tmp        " バックアップファイルの場所を変更
set directory=~/dotfiles/vim/tmp        " 一時ファイルの場所を変更
set title                       " タイトルの表示
set showmatch                   " 括弧の対応をハイライト
set number                      " 行番号表示
" OSのクリップボードを使う
set clipboard+=unnamed

" □とか○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double

" ファイルタイプ判定をon
filetype plugin on

scriptencoding utf-8
set encoding=utf-8

set backspace=indent,eol,start

" カラースキームの設定
set t_Co=256
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termtrans=1
colorscheme solarized

syntax enable

if has('persistent_undo')
  set undodir=~/dotfiles/vim/undo
  set undofile
endif
