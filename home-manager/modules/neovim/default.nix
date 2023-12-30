{ pkgs, ...}:
{
programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = (builtins.concatStringsSep "\n" [
       (builtins.readFile ./settings.lua)
    ]);

    extraPackages = with pkgs; [
        #some language servers
        ccls
        lua-language-server
        nil
    ];

    plugins = with pkgs.vimPlugins; [
        rainbow

	    kanagawa-nvim
	    palenight-vim
	    tokyonight-nvim
        onehalf

        nvim-web-devicons
        {
            plugin = lualine-nvim;
            type = "lua";
            config = builtins.readFile ./lualine.lua;
        }
	
        {
            plugin = nvim-lspconfig;
            type = "lua";
            config = builtins.readFile ./lsp.lua;
        }

        vim-gitgutter
        vim-css-color

        {
            plugin = (nvim-treesitter.withPlugins (p: [
                p.tree-sitter-nix
                p.tree-sitter-c
                p.tree-sitter-cpp
                p.tree-sitter-lua
                p.tree-sitter-vim
                p.tree-sitter-python
                p.tree-sitter-bash
                p.tree-sitter-markdown
            ]));

            type = "lua";
            config = builtins.readFile ./treesitter.lua;
        }
   ];
};
}
