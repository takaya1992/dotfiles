call ddc#custom#patch_global('sources', ['vim-lsp', 'around'])


call ddc#custom#patch_global('sourceOptions', {
      \ 'vim-lsp': {
      \   'matchers': ['matcher_head'],
      \   'mark': 'lsp',
      \ },
      \ 'around': {'mark': 'A'},
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })
call ddc#enable()
