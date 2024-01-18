{ config, lib, ...}:
with lib;
let
  cfg = config.dotfiles.home-manager.bash;
in
{
    imports = [];
    
    options.dotfiles.home-manager.bash = {
        enable = mkEnableOption "bash module";
        repoFolder = mkOption {
            description = ".files folder";
            default = "~/.files";
            type = types.str;
        };
        hm = mkOption {
            description = "home-manager profile name";
            default = "azevedo";
            type = types.str;
        };
        nos = mkOption {
            description = "nixos profile name";
            default = "home-pc";
            type = types.str;
        };
    };

    config = mkIf cfg.enable {
        programs.bash = {
            enable = true;

            shellAliases = {
                "reload"="source ${config.home.homeDirectory}/.bashrc";

                "mysql"="mysql -u root -p";
            
                "ls" = "ls --colo=auto";
                "ll" = "ls -l";
                "la" = "ls -la";

                ".." = "cd ..";
                "..." = "cd ../../";

                "g" = "git";
                
                "dotfiles"="lf ${cfg.repoFolder}";
                "home-manager"="home-manager --flake ${cfg.repoFolder}#${cfg.hm}";
                "nixos-rebuild" = "nixos-rebuild --flake ${cfg.repoFolder}#${cfg.nos}";
            };

            profileExtra = "";
            
            initExtra = ''
                YELLOW='\[\e[1;33m\]'
                GREY='\[\e[0;37m\]'
                PS1="$YELLOW\t \W > $GREY"
            '';

            #bashrcExtra = builtins.readFile Assets/fuc;

            shellOptions = [
                "histappend"    # append to history file, dont overwrite it
                "checkwinsize"  # checkwindow size after each command
                "nocaseglob"    # case insensitive globbing
                "cdspell"       # autocorrect typos in path names in cd
            ];

            sessionVariables = {
                CLICOLOR = "1";
                LSCOLORS = "gxfxcxdxbxegedabagacad";

                GREP_OPTIONS = "-color=auto";
                HISTCONTROL="ignoreboth";
                TERMINAL = "alacritty";
            }; 

            historySize = 2000;
            historyFileSize = 10000;
        };
    };
}
