call ddc#custom#patch_global('sources', ['vim-lsp', 'vsnip', 'around'])
call ddc#custom#patch_global('sourceOptions', {
      \ 'vim-lsp': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'LSP',
      \   'forceCompletionPattern': '\\.|:|->',
      \ },
      \ 'vsnip': {'mark': 'vsnip'},
      \ 'around': {'mark': 'A'},
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \   'minAutoCompleteLength': 1,
      \   'forceCompletionPattern': '\\.|:|->',
      \ })
call ddc#enable()

call popup_preview#enable()

" TAB で候補を移動
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 補完確定時に Enter で改行しない
inoremap <expr><CR>  pumvisible() ? "<C-y>" : "<CR>"
