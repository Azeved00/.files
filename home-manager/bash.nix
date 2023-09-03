{ config, pkgs, lib, ...}:
{
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

            "dotfiles"="ranger ${config.home.homeDirectory}/.files/";
        };

        profileExtra = "";
        
        initExtra = ''
            eval $(ssh-agent)
            YELLOW='\[\e[1;33m\]'
            GREY='\[\e[0;37m\]'
            PS1="$YELLOW\t \W > $GREY"
        '';

        bashrcExtra = builtins.readFile "${config.home.homeDirectory}/.files/System/func";

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
}
