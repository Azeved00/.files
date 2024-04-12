{ pkgs, inputs, ...}:
{
    imports = [
    ];

    home = {
        username = "azevedo";
        homeDirectory = "/home/azevedo";
        stateVersion = "23.05";
    };

    nix= {
        package = pkgs.nix;
        settings = {
            experimental-features = ["nix-command" "flakes"];
        };
    };



    programs.home-manager.enable = true;
    programs.java = {
        enable = true;
        package = pkgs.jdk8;
    };
}
