{pkgs, ...}:
{
    home-manager.useGlobalPkgs = true;  
    home-manager.users.azevedo = { config, pkgs, ... }: {
        home.stateVersion = "23.05";
        home.packages = [ ];
        
        programs.git = {
            enable = true;
            userName  = "João Azevedo";
            userEmail = "62391524+Azeved00@users.noreply.github.com";

            extraConfig = {
                advice = {
                    addIgnoredFile = false;
                };
                fetch = {
                    prune = true;
                };
                diff = {
                    colorMoved = "zebra";
                };
                core =  {
                    editor = "nvim";
                    autocrlf = false;
                };
                init = {
                    defaultBranch = "main";
                };
                pull = {
                    rebase = false;
                };
                push = {
                    autoSetupRemote = true;
                };
            };
        };

        programs.bash = {
            enable = true;

            shellAliases = {
                "reload"="source ~/.bashrc";

                "mysql"="mysql -u root -p";
            
                "ls" = "ls --colo=auto";
                "ll" = "ls -l";
                "la" = "ls -la";

                ".." = "cd ..";
                "."  = "ls .";
                "..." = "cd ../../";

                "ga" = "git add";
                "gs" = "git status";
                "gp" = "git push";
                "gf" = "git fetch && git pull && git fetch";
                "gc" = "git commit -m";
                "gsmod" = "git submodule sync && git submodule update --init --recursive";
                
                "dotfiles"="ranger ~/.files/";
            };

            profileExtra = "";
            
            initExtra = ''
                eval $(ssh-agent)
                YELLOW='\[\e[1;33m\]'
                GREY='\[\e[0;37m\]'
                PS1="$YELLOW\t \W > $GREY"
            '';

            bashrcExtra = "";

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
        
        programs.neovim = {
            enable = true;
            defaultEditor = true;
        };

        programs.readline = {
            enable = true;
            bindings = {
                "\\e[Z" = "menu-complete";
                "\\e[A" = "history-search-backward";
                "\\e[B" = "history-search-forward";
            };
            variables = {
                completion-ignore-case = true;
                show-all-if-ambiguous = true;
            };
        };

        programs.ssh = {
            enable = true;

            matchBlocks = {
                "github.com" = {
                    hostname = "github.com";
                    user="git";
                    identityFile = "~/.ssh/main";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "second" = {
                    hostname = "github.com";
                    user = "git";
                    identityFile="~/.ssh/second";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "gitlab" = {
                    hostname = "gitedu.alunos.dcc.fc.up.pt";
                    user = "git";
                    identityFile="~/.ssh/gitlab";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };
            };
        };

        programs.home-manager.enable = true;
   };
}
