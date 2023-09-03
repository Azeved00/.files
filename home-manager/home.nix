{ pkgs, ...}:
{
    imports = [
        ./git.nix
        ./bash.nix
        ./readline.nix
        ./neovim/program.nix 
        ./ssh.nix
    ] 
    ++ (if builtins.getEnv "WSL_DISTRO_NAME" == "" 
    	then [ 
            ./alacritty.nix
            ./picom.nix
            ./polybar.nix 
            ./rofi.nix
            ./i3.nix
    	] 
    	else []
    );


    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages =  with pkgs; [ 
        prismlauncher
        steam
        dolphin-emu
        parsec-bin
	    heroic

        spotify
    ];

    nixpkgs.config = {
        allowUnfree = true;
        pulseaudio = true;
    };
    #nix= {
    #    package = pkgs.nix;
    #    settings = {
    #        experimental-features = ["nix-command"];
    #    };
    #};

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

    programs.home-manager.enable = true;
}
