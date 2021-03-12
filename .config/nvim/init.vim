" vim-plug
call plug#begin('~/.local/share/nvim/plugged')

Plug 'overcache/NeoSolarized'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

call plug#end()
" end vim-plug

" solarized
set background=light
colorscheme NeoSolarized
set termguicolors

" vim-wiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
