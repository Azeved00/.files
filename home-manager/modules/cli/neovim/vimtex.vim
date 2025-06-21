let g:vimtex_compiler_latexmk = {
    \ 'executable': 'latexmk',
    \ 'out_dir': 'out',
    \ 'build_dir': 'build',
    \ 'options': [
        \ '-shell-escape',
        \ '-xelatex',
        \ '-file-line-error',
        \ '-synctex=1',
        \ '-interaction=nonstopmode',
    \ ],
\ }

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_indent_enabled = 0

let g:vimtex_syntax_conceal = {
      \ 'accents': 1,
      \ 'ligatures': 1,
      \ 'cites': 1,
      \ 'fancy': 1,
      \ 'spacing': 1,
      \ 'greek': 1,
      \ 'math_bounds': 1,
      \ 'math_delimiters': 1,
      \ 'math_fracs': 1,
      \ 'math_super_sub': 1,
      \ 'math_symbols': 1,
      \ 'sections': 1,
      \ 'styles': 1,
\ }

let g:vimtex_syntax_conceal_cites = {
      \ 'type': 'brackets',
      \ 'icon': '📖',
      \ 'verbose': v:true,
\ }

set conceallevel=2

let g:vimtex_toc_enabled = 0
let g:vimtex_indent_bib_enabled = 0


let g:vimtex_syntax_custom_cmds = [
    \ {'name': 'az'},
    \]

