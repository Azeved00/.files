{pkgs, ...}: {


    imports =  [ ];

    dotfiles.home-manager = {
        alacritty.enable = true;
        bash = {
            enable = true;
            repoFolder = "~/.files";
            hm = "azevedo";
        };
        dunst.enable = true;
        git.enable = true;
        i3= {
            enable = true;
            background-image = ../../assets/Pictures/Backgrounds/fractal.png;
        };
        lf.enable = true;
        nvim.enable = true;
        picom.enable = true;
        polybar.enable = true;
        readline.enable = true;
        rofi.enable = true;
        ssh.enable = true;
    };
    programs.tmux.enable = true;
    programs.firefox.enable = true;


    home.packages = with pkgs; [ 
            prismlauncher
	        heroic
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
            parsec-bin
            obs-studio
    ];

    bright-bit.user.enable = true;

    xdg = {
        enable = true;

        mimeApps.defaultApplications = {
            "text/plain" = [ "neovim.desktop" ];
            "application/pdf" = [ "zathura.desktop" ];
        };

        userDirs = {
            enable = true;
            createDirectories = false;
        };
    };

    nixpkgs.config.permittedInsecurePackages = [
        "electron-24.8.6"
    ];

}
