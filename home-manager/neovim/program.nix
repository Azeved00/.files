{ config, pkgs, ...}:
{
home.activation.installNvimConfig = ''
    #if [ -d "${config.xdg.configHome}/nvim" ]; then
    #    rm ${config.xdg.configHome}/nvim
    #fi
    # ln -s "${config.home.homeDirectory}/.files/Config/nvim" "${config.xdg.configHome}/nvim"
'';


programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = (builtins.concatStringsSep "\n" [
       (builtins.readFile ./settings.lua)
       (builtins.readFile ./lualine.lua)
       (builtins.readFile ./lsp.lua)
    ]);

    extraPackages = [
        #some language servers
        pkgs.ccls
        pkgs.lua-language-server
        pkgs.nil
    ];

    plugins = with pkgs.vimPlugins; [
        rainbow
        {
            plugin = kanagawa-nvim;
            config = "colorscheme kanagawa-wave";
        }


        nvim-web-devicons
        {
            plugin = lualine-nvim;
            config = "luafile ~/.config/home-manager/neovim/lualine.lua";
        }
	
        nvim-lspconfig
        vim-gitgutter
        (nvim-treesitter.withPlugins (
            plugins: with plugins; [
                nix
                c
                cpp
                lua
                vim
            ]
        ))
   ];
};
}
