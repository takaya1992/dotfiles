" 検索系

set incsearch  "インクリメンタルサーチを行う
set hlsearch   "検索結果をハイライトする
set ignorecase "検索時に文字の大小を区別しない
set smartcase  "検索時に大文字を含んでいたら大小を区別する
set wrapscan   "検索をファイルの先頭へループする

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>
