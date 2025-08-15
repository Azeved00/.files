{pkgs, inputs, ...}: 

{
    imports =  [ ./shared.nix];

    dotfiles.home-manager = {
        alacritty.enable = true;
        desktop = {
            enable = true;

            i3= {
                enable = true;
                mod ="Mod1";
                background-image = ../../assets/Pictures/Backgrounds/fractal.png;
                polybar.enable = false;
                monitor-config = ''
                    workspace 6 output DP-3
                    workspace 1 output HDMI-1
                '';
            };
        };
        lf.enable = true;
        nvim.enable = true;
        feh.enable = true;
        firefox.enable = false;
        zathura.enable = true;
        drawio.enable = true;

        bash = {
            enable = true;
            repoFolder = "~/Dev/config/dotfiles";
            hm = "blizzard";
            nos = "blizzard";
        };
        git.enable = true;
        readline.enable = true;
        ssh.enable = true;
        tmux.enable = true;
        terminal.packages.enable = true;
    };

    programs.dev-command = {
        enable = true;
        settings = {
            sessions.dotfiles = {
                path = "$HOME/Dev/config/dotfiles";
                title = "dotfiles";
                windows = [
                    {title = "edit";}
                    {title = "switch";}
                ];
            };
            sessions.writting= {
                path = "$HOME/Dev/investigacao/Thesis";
                title = "Thesis-Writting";
                git = true;
                windows = [
                    {title = "main"; nix_shell = "default";}
                    {title = "biblio"; nix_shell = "default";}
                ];
            };
            sessions.thesis = {
                path = "$HOME/Dev/investigacao/matrixcrdt";
                title = "Thesis";
                git = true;
                windows = [
                    {title = "Dev 1"; nix_shell = "dev";}
                    {title = "Dev 2"; nix_shell = "dev";}
                    {title = "Run"; nix_shell = "run";}
                    {title = "Graph"; nix_shell = "graph";}
                ];
            };
            sessions.tracker = {
                path = "$HOME/Dev/tracker";
                title = "Tracker";
                git = false;
                windows = [
                    {title = "Dev 1"; nix_shell = "default";}
                    {title = "Dev 2"; nix_shell = "default";}
                    {title = "Run"; nix_shell = "default";}
                ];
            };

        };
    };

    services.caffeine.enable = true;


    home.packages = with pkgs; [ 
            pinta
            krita
            inputs.zen-browser.packages.x86_64-linux.default
            spotify
            discord
            zoom-us
            stremio
    ];


}
