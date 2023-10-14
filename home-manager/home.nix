{ pkgs, ...}:
let
    notWSL = builtins.getEnv "WSL_DISTRO_NAME" == "";

in
{
    imports = [
        ./apps/git.nix
        ./apps/bash/program.nix
        ./apps/readline.nix
        ./apps/neovim/program.nix 
        ./apps/ssh.nix
        ./apps/lf/program.nix
    ] 
    ++ (if notWSL then 
        [ 
            ./apps/alacritty.nix
            ./apps/picom.nix
            ./apps/polybar.nix 
            ./apps/rofi.nix
            ./apps/i3/program.nix
            ./apps/dunst.nix
    	] 
    	else []
    );


    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages = (
    if notWSL then 
        with pkgs; [ 
            prismlauncher
            dolphin-emu
            parsec-bin
	        heroic
            retroarchBare

            spotify
            discord
        ] 
    else []);

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
    programs.java = {
        enable = true;
        package = pkgs.jdk8;
    };
}
