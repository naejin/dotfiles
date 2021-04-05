" Vim plug
" ------------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')

" Theme
" ------------------------------------------------------------------------------
Plug 'overcache/NeoSolarized'

" Git
" ------------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'

" Status bar
" ------------------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Finding and replacing
" ------------------------------------------------------------------------------
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Editing
" ------------------------------------------------------------------------------
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align'

" Tags
" ------------------------------------------------------------------------------
Plug 'ludovicchabant/vim-gutentags'

" Zettelkasten
" ------------------------------------------------------------------------------
Plug 'michal-h21/vim-zettel'
Plug 'vimwiki/vimwiki'

" LSP
" ------------------------------------------------------------------------------
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

call plug#end()

"  General config
" ------------------------------------------------------------------------------

" Enable term 24 bit colour
set termguicolors

" Syntax and indent
syntax enable
filetype plugin indent on

" Line numbers
set number
set relativenumber

" Use ``indent`` based folding
set foldmethod=indent
" Disable all folds on file open until `zc` or `zM` etc is used
set nofoldenable

" Fixed sign column to remove jitter
set signcolumn=yes

" Make it obvious where 80 characters is
set colorcolumn=80

" Don't display the current mode (Insert, Visual, Replace)
" in the status line. This info is already shown in the
" Airline status bar.
set noshowmode

" Show col and line position in the statusbar
set ruler

" Highlight current line
set cursorline

" Spellcheck
set spelllang=en,cjk
nnoremap <silent> <F12> :set spell!<cr>
inoremap <silent> <F12> <C-O>:set spell!<cr>

" NeoSolarized config
" ------------------------------------------------------------------------------

" Default value is "normal", Setting this option to "high" or "low" does use the
" same Solarized palette but simply shifts some values up or down in order to
" expand or compress the tonal range displayed.
let g:neosolarized_contrast = "normal"

" Special characters such as trailing whitespace, tabs, newlines, when displayed
" using ":set list" can be set to one of three levels depending on your needs.
" Default value is "normal". Provide "high" and "low" options.
let g:neosolarized_visibility = "normal"



" I make vertSplitBar a transparent background color. If you like the origin
" solarized vertSplitBar style more, set this value to 0.
let g:neosolarized_vertSplitBgTrans = 1

" If you wish to enable/disable NeoSolarized from displaying bold, underlined
" or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
" Default values:
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 0

" Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
" text output by commands like `ls` aren't what you expect, you might want to
" try disabling this option. Default value:
let g:neosolarized_termBoldAsBright = 1

colorscheme NeoSolarized
set background=light

" vim-airline config
" ------------------------------------------------------------------------------
let g:airline_theme='solarized'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#whitespace#mixed_indent_algo = 2

" vim-easy-align
" ------------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gq <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gq <Plug>(EasyAlign)

" vim-wiki config
" ------------------------------------------------------------------------------
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" LSP config
" ------------------------------------------------------------------------------

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
:lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable lsp
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
nvim_lsp.pyright.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

