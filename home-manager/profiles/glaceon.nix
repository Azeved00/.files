{pkgs, ...}: {


    imports =  [ ./shared.nix ];

    dotfiles.home-manager = {
        desktop = {
            enable = true;
            eww.enable = false;
            dunst.enable = true;
            rofi.enable = true;
            i3= {
                enable = true;
                background-image = ../../assets/Pictures/Backgrounds/river.jpg;
                polybar = {
                    enable = true;
                    modules.bluetooth.enable = false;
                    modules.battery.enable = true;
                    modules.battery.battery = "BAT0";
                    modules.wifi.wifi-interface = "wlp5s0";
                };
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
            repoFolder = "~/Dev/config/dotfiles";
            hm = "glaceon";
            nos = "glaceon";
        };
    };

    programs.dev-command = {
        enable = true;
        settings = {
            sessions.dotfiles = {
                path = "$HOME/Dev/config/dotfiles";
                title = "Dot Files";
                windows = [
                    {title = "edit";}
                    {title = "switch";}
                ];
            };
            sessions.homelab = {
                path = "$HOME/Dev/config/homelab";
                title = "HomeLab";
                windows = [
                    {title = "edit";}
                    {title = "deploy";}
                    {title = "ssh";}
                ];
            };

            sessions.acrdt = {
                path = "$HOME/Dev/FCUP/ACRDT";
                title = "ACRDT";
                windows = [
                    {title = "1"; nix_shell = "dev";}
                    {title = "2";}
                    {title = "3"; nix_shell = "run";}
                    {title = "4";}
                ];
            };
        };
    };

    home.packages = with pkgs; [ 
        pinta
    ];
}
