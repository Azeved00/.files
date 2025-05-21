{pkgs, ...}: {


    imports =  [ ./shared.nix ];

    dotfiles.home-manager = {
        desktop = {
            enable = true;
            eww.enable = true;
            dunst.enable = true;
            rofi.enable = true;
            i3= {
                enable = true;
                background-image = ../../assets/Pictures/Backgrounds/river.jpg;
                polybar.enable = false;
                monitor-config = ''
                    workspace 1 output eDP-1
                '';
            };
        };
        alacritty.enable = true;
        feh.enable = true;
        zathura.enable = true;
        drawio.enable = true;

        nvim.enable = true;
        lf.enable = true;
        tmux.enable = true;
        terminal.packages.enable = true;
        git.enable = true;
        readline.enable = true;
        ssh.enable = true;
        bash = {
            enable = true;
            repoFolder = "~/Dev/dotfiles";
            hm = "glaceon";
            nos = "glaceon";
        };
    };

    programs.dev-command = {
        enable = true;
        settings = {
            sessions.dotfiles = {
                path = "$HOME/Dev/dotfiles";
                title = "dotfiles";
            };
            sessions.thesis = {
                path = "$HOME/Dev/matrixcrdt";
                title = "Thesis";
                windows = [
                    {title = "Dev 1"; nix_shell = "dev";}
                    {title = "Dev 2"; nix_shell = "dev";}
                    {title = "Run"; nix_shell = "run";}
                    {title = "Graph"; nix_shell = "graph";}
                ];
            };

            sessions.writting = {
                path = "$HOME/Dev/thesis";
                title = "Thesis Writting";
                windows = [
                    {title = "Base"; nix_shell = "default";}
                    {title = "Edit"; nix_shell = "default";}
                ];
            };

            sessions.ns = {
                path = "$HOME/Dev/NS_Homework2";
                title = "NetworkScience";
                windows = [
                    {title = "Base"; nix_shell = "default";}
                    {title = "Edit"; nix_shell = "default";}
                ];
            };
        };
    };

    home.packages = with pkgs; [ 
        pinta
        spotify
        zoom-us
        teams-for-linux
    ];
}
