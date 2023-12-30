-- 'folke/tokyonight.nvim'
-- 'rebelot/kanagawa.nvim'
-- 'drewtempelmeyer/palenight.vim'
local v = vim

return {
    "airblade/vim-gitgutter",
    "luochen1990/rainbow",

    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            v.cmd("colorscheme kanagawa-wave")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enable = true,
                theme = 'gruvbox',
            })
        end,
    },
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
}
