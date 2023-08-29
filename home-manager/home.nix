{config, pkgs, lib, ...}:
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
    	] 
    	else []
    );


    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages = [ pkgs.rofi ];

    home.file = {};
        
    xdg.mimeApps.defaultApplications = {
        "text/plain" = [ "neovim.desktop" ];
        "application/pdf" = [ "zathura.desktop" ];
    };

    programs.home-manager.enable = true;
}
