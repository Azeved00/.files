{ config, pkgs, lib, ...}:

programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    #extraConfig = ''
    #    luafile $HOME/.config/home-manager/neovim/settings.lua
    #'';
    extraLuaConfig = builtins.readFile ./settings.lua;
    
    plugins = with pkgs.vimPlugins; [
        vim-gitgutter
        {
            plugin = kanagawa-nvim;
            config = "colorscheme kanagawa-wave";
        }
        
        nvim-web-devicons
        {
            plugin = lualine-nvim;
            config = "luafile ~/.config/home-manager/neovim/lualine.lua";

        }


        nvim-treesitter
        
    ];
};
}
