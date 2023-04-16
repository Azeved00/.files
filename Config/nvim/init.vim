set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set encoding=UTF-8
set expandtab
set foldmethod=indent
set nofoldenable
set foldlevel=99

"nnoremap <silent> <C-f> za<CR>
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-t> :terminal<CR>
tnoremap <silent> <Esc> <C-\><C-n>:bdelete! <CR>
"nnoremap <silent> <C-w> :q<CR>
"tabs and stuff
nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <C-w> :bdelete!<CR>

" copy and paste
set clipboard+=unnamedplus

"add all plugs
call plug#begin()
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'airblade/vim-gitgutter' "git shannanigans
Plug 'jiangmiao/auto-pairs'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
"Plug 'neoclide/coc.nvim'
Plug 'https://github.com/dense-analysis/ale' "linting
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'AndrewRadev/tagalong.vim'
Plug 'tpope/vim-surround'
"Plug 'abdalrahman-ali/vim-remembers'

"Color schemes
"Plug 'https://github.com/xiyaowong/nvim-transparent'
"Plug 'https://github.com/arcticicestudio/nord-vim'
"Plug 'https://github.com/sainnhe/everforest'
"Plug 'https://github.com/rakr/vim-one'
"Plug 'https://github.com/sheerun/vim-wombat-scheme'
Plug 'folke/tokyonight.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'drewtempelmeyer/palenight.vim'
"Plug 'mhartington/oceanic-next'
"Plug 'https://github.com/sonph/onehalf'
"Plug 'jackm245/nordark.nvim'
call plug#end()

"themes and colors
"set background=dark
colorscheme kanagawa-wave
set background=dark
let g:rainbow_active=1
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
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['^.git$', '^.idea$', '^.vscode$', '^.history$', '^node_modules$']

"let g:NERDTreeDirArrowExpandable="^"
"let g:NERDTreeDirArrowCollapsible=">"
" Exit Vim if NERDTree is the only window remaining in the only tab.
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif


" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif


" --- Just Some Notes ---

" :PlugClean :PlugInstall :UpdateRemotePlugins
"
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE
let g:airline#extensions#tabline#enabled = 1 

" air-line settings
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
let g:airline_theme='wombat'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode',' ', 'branch'])
    let g:airline_section_c = airline#section#create(['%f'])
    let g:airline_section_y = airline#section#create([''])
    let g:airline_section_z = airline#section#create(['ln: %l'])
endfunction
autocmd VimEnter * call AirlineInit()

let g:airline_section_y = airline#section#create_right(['ffenc','foo'])
"linting
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['gcc'],
    \ 'c': ['gcc'],
    \ 'sql': ['sql-lint'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['eslint'],
    \ 'html': ['htmlhint'],
    \ 'css': ['stylelint'],
    \ 'pl': ['swipl']
\}
let g:ale_fixers = {
    \ 'html': ['prettier'],
    \ 'css': ['stylelint'],
\}
let g:ale_fix_on_save = 1


"html dev settings
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','

let g:tagalong_verbose = 1

"--- Dont forget PlugInstall to install every plugin---

let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = v:true

let g:rainbow_conf = {
    \'separately': {
        \'haskell': {
            \'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
        \},
        \'css': 0,
        \'html': 0,
        \'nerdtree': 0,
    \},
\}
