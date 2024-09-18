{pkgs, ...}: {


    imports =  [ ];

    dotfiles.home-manager = {
        alacritty.enable = true;
        desktop = {
            enable = true;

            i3= {
                enable = true;
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
            repoFolder = "~/Dev/dotfiles";
            hm = "blizzard";
            nos = "blizzard";
        };
        git.enable = true;
        readline.enable = true;
        ssh.enable = true;
        tmux.enable = true;
        terminal.packages.enable = true;
    };

    home.packages = with pkgs; [ 
            prismlauncher
	        heroic
            pinta
            krita
            (retroarch.override {
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
    ];

    bright-bit.user.enable = true;


    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];

}
