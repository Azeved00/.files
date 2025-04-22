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


    home.packages = with pkgs; [ 
        pinta
        spotify
        zoom-us
        teams-for-linux
    ];
}
