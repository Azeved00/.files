{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.nvim;
    vimtexPkgs = pkgs.vimPlugins.vimtex;
    vimtexSite  = "${toString vimtexPkgs}/share/vim-plugins/vimtex";
in
{
    options.dotfiles.home-manager.nvim= {
        enable = lib.mkEnableOption "Enable nvim module";

        lsps = lib.mkOption {
            description = "Add Extra lsp configurations to neovim.
                These will be appended to lsp.lua file"; 
            default = "";
            type = lib.types.str;
            example = "
            require('lspconfig').ccls.setup {
                 on_attach = on_attach,
                 capabilities = capabilities,
            }";
        };
    };

    config = lib.mkIf cfg.enable {
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            viAlias = true;
            vimAlias = true;

            extraLuaConfig = (builtins.concatStringsSep "\n" [
               (builtins.readFile ./settings.lua)
            ]);

            extraConfig = ''
              " Force vimtex’s ftplugin to load before the builtin one
              if isdirectory('${vimtexSite}')
                set runtimepath^='${vimtexSite}'
              endif
            '';

            # some default language servers
            extraPackages = with pkgs; [
                ccls
                lua-language-server
                nil
            ];

            plugins = with pkgs.vimPlugins; [
                {
                    plugin = nvim-treesitter.withAllGrammars;
                    type = "lua";
                    config = builtins.readFile ./treesitter.lua;
                }
                {
                    plugin = rainbow-delimiters-nvim;
                    type = "lua";
                    config = builtins.readFile ./rainbow.lua;
                }
               

                #kanagawa-nvim
                #palenight-vim
                #tokyonight-nvim
                #onehalf

                nvim-web-devicons
                {
                    plugin = lualine-nvim;
                    type = "lua";
                    config = builtins.readFile ./lualine.lua;
                }
            
                {
                    plugin = nvim-lspconfig;
                    type = "lua";
                    config = (builtins.concatStringsSep "\n" [
                        (builtins.readFile ./lsp.lua)
                        cfg.lsps
                    ]);
                }

                vim-gitgutter
                vim-css-color
                {
                    plugin = render-markdown-nvim;
                    type = "lua";
                    config = builtins.readFile ./markdown.lua;
                }
                {
                    plugin = vimtex;
                    config = ''
                        let g:vimtex_compiler_latexmk = { 
                                \ 'executable' : 'latexmk',
                                \ 'out_dir' : 'out',
                                \ 'options' : [ 
                                \   '-xelatex',
                                \   '-file-line-error',
                                \   '-synctex=1',
                                \   '-interaction=nonstopmode',
                                \ ],
                                \}
                        let g:vimtex_view_method='zathura'
                        let g:vimtex_quickfix_mode=0
                        set conceallevel=1
                        let g:tex_conceal='abdmg'
                    '';
                }

           ];
        };
    };
}
