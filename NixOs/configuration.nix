{ ... }:
{
    imports =
    [ 
        ./modules/users.nix
        ./modules/network.nix
        ./modules/fonts.nix
        ./modules/xserver.nix
        ./modules/packages.nix
        ./modules/local.nix
        ./modules/services.nix
        ./modules/variables.nix
    ] ;


    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.experimental-features = [ "nix-command flakes" ];
    
    system.stateVersion = "23.05"; 
}

