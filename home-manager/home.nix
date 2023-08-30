{config, pkgs, lib, ...}:
{
    imports = [
        ./git.nix
        ./bash.nix
        ./readline.nix
        ./neovim.nix 
        ./ssh.nix
    ] 
    ++ (if builtins.getEnv "WSL_DISTRO_NAME" == "" 
    	then [ 
            ./alacritty.nix
            ./picom.nix
            ./polybar.nix 
            ./rofi.nix
    	] 
    	else []
    );


    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages = [ pkgs.rofi ];

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
