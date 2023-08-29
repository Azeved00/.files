
local o = vim.o
local g = vim.g

vim.cmd [[
    set nowrap
    set nobackup
    set nowritebackup
    set noswapfile
    set nofoldenable
]]

g.mapleader = ' '
g.maplocalleader = ' '
o.encoding = 'UTF-8'

o.clipboard = 'unnamedplus'

o.number = true
o.relativenumber = true
o.updatetime = 300
o.termguicolors = true
o.cursorline = true

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

vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>",  {noremap = true, silent = true} )
