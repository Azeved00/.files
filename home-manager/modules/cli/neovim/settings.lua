local v = vim
local o = v.o
local g = v.g

v.cmd [[
    set nowrap
    set nobackup
    set nowritebackup
    set noswapfile
    set nofoldenable
    set splitright
    set splitbelow

    syntax on
    colorscheme bright-bit
]]

g.mapleader = ' '
g.maplocalleader = ' '
g.rainbow_active = 1
o.encoding = 'UTF-8'

o.clipboard = 'unnamedplus'

o.number = true
o.relativenumber = true
o.updatetime = 300
o.termguicolors = true
o.cursorline = true
o.background = "dark"

o.signcolumn = 'yes'

o.smarttab = true
o.softtabstop = 4
o.tabstop = 4
o.shiftwidth = 4

o.autoindent = true
o.expandtab = true

o.foldmethod = 'indent'
o.foldlevel = 99

o.mouse = 'a'
o.hidden = true

v.api.nvim_set_keymap("n", "<leader>w", ":w<CR>",  {noremap = true, silent = true} )
v.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-N><CR>", {noremap = true, silent = false} )
v.api.nvim_set_keymap("t", '<C-w>', "<C-\\><C-O><C-w>",{silent = false})

