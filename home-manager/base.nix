{ pkgs, ...}:
{
    imports = [
        ./apps/git.nix
        ./apps/bash/program.nix
        ./apps/readline.nix
        ./apps/neovim/program.nix 
        ./apps/ssh.nix
        ./apps/lf/program.nix
    ];


    home.username = "azevedo";
    home.homeDirectory = "/home/azevedo";
    home.stateVersion = "23.05";
    home.packages = [];

    nixpkgs.config = {
        allowUnfree = true;
        pulseaudio = true;
    };
    nix= {
        package = pkgs.nix;
        settings = {
            experimental-features = ["nix-command" "flakes"];
        };
    };

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
