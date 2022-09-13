:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-t> :terminal<CR>
:tnoremap <Esc> <C-\><C-n>
"nnoremap <silent> <C-w> :q<CR>
" copy and paste
set clipboard+=unnamedplus
call plug#begin()

Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'airblade/vim-gitgutter' "git shannanigans
Plug 'jiangmiao/auto-pairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
"Plug 'neoclide/coc.nvim'
Plug 'https://github.com/dense-analysis/ale' "linting

"Color schemes
"Plug 'https://github.com/xiyaowong/nvim-transparent'
Plug 'https://github.com/arcticicestudio/nord-vim'
Plug 'https://github.com/sainnhe/everforest'
"Plug 'https://github.com/rakr/vim-one'
"Plug 'https://github.com/sheerun/vim-wombat-scheme'
Plug 'drewtempelmeyer/palenight.vim'
"Plug 'mhartington/oceanic-next'
"Plug 'https://github.com/sonph/onehalf'
"Plug 'jackm245/nordark.nvim'
set encoding=UTF-8

call plug#end()

"themes and colors
"set background=dark
colorscheme palenight
set background=dark
":TransparentEnable
"highlight Comment ctermfg=DarkGray
"highlight Constant ctermfg=Blue
"highlight Normal ctermfg=White
"highlight NonText ctermfg=Black
"highlight Special ctermfg=DarkMagenta
"highlight Cursor ctermfg=Green
"hi! Normal ctermbg=NONE guibg=NONE
"hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

"nerd tree settings
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
nnoremap <silent> <C-a> :NERDTreeFocus<CR>

"let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['^.git$', '^.idea$', '^.vscode$', '^.history$', '^node_modules$']
"let g:NERDTreeDirArrowExpandable="^"
"let g:NERDTreeDirArrowCollapsible=">"
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" --- Just Some Notes ---

" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE

"tabs and stuff
nnoremap <silent> <C-left> :BufferPrevious<CR>
nnoremap <silent> <C-right> :BufferNext<CR>
nnoremap <silent> <C-w> :BufferClose!<CR>

" air-line settings
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
let g:airline_theme='wombat'
let g:airline#extensions#ale#enabled = 1

"linting
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['gcc'],
    \ 'c': ['gcc'],
	\ 'sql': ['sql-lint'],
	\ 'javascript': ['eslint'],
	\ 'typescript': ['eslint'],
\}


