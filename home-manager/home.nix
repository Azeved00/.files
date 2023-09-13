{ pkgs, ...}:
let
    notWSL = builtins.getEnv "WSL_DISTRO_NAME" == "";

in
{
    imports = [
        ./git.nix
        ./bash.nix
        ./readline.nix
        ./neovim/program.nix 
        ./ssh.nix
    ] 
    ++ (if notWSL then 
        [ 
            ./alacritty.nix
            ./picom.nix
            ./polybar.nix 
            ./rofi.nix
            ./i3.nix
            ./dunst.nix
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

            spotify
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
