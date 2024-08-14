call ddc#custom#patch_global('sourceParams', {
      \   'dictionary': {
      \     'dictPaths': [
      \       $HOME . '/dotfiles/dict/words.txt',
      \       $HOME . '/dotfiles/dict/words-local.txt',
      \     ],
      \     'smartCase': v:true,
      \     'showMenu': v:false,
      \   }
      \ })

call ddc#custom#patch_global('sources', ['vim-lsp', 'vsnip', 'around', 'dictionary'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'vim-lsp': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'LSP',
      \   'forceCompletionPattern': '\\.|:|->',
      \ },
      \ 'vsnip': {'mark': 'vsnip'},
      \ 'around': {'mark': 'A'},
      \ 'dictionary': {
      \   'mark': 'Dict',
      \ },
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank'],
      \   'minAutoCompleteLength': 1,
      \   'forceCompletionPattern': '\\.|:|->',
      \ }})

call ddc#custom#patch_global('ui', 'native')

call ddc#enable()

call popup_preview#enable()

" TAB で候補を移動
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 補完確定時に Enter で改行しない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
