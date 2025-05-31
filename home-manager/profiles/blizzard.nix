{pkgs, inputs, ...}: {
    imports =  [ ./shared.nix ];

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
        firefox.enable = true;
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
                title = "dot files";
            };
            sessions.writting= {
                path = "$HOME/Dev/investigacao/Thesis";
                title = "Thesis Writting";
                windows = [
                    {title = "A"; nix_shell = "default";}
                    {title = "B"; nix_shell = "default";}
                ];
            };
            sessions.thesis = {
                path = "$HOME/Dev/investigacao/matrixcrdt";
                title = "Thesis";
                windows = [
                    {title = "Dev 1"; nix_shell = "dev";}
                    {title = "Dev 2"; nix_shell = "dev";}
                    {title = "Run"; nix_shell = "run";}
                    {title = "Graph"; nix_shell = "graph";}
                ];
            };

        };
    };

    services.caffeine.enable = true;

    home.packages = with pkgs; [ 
            prismlauncher
	        heroic
            pinta
            krita
            inputs.zen-browser.packages.x86_64-linux.default
            (retroarch-bare.wrapper {
                cores = with libretro; [
                    dolphin
                    #citra
                    beetle-gba
                    beetle-psx-hw
                    #pcsx2
                ];
            })
            spotify
            discord
            zoom-us
            stremio
    ];


}
