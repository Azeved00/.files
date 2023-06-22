{ config, pkgs, ... }:
{
    imports =
    [ 
        /etc/nixos/hardware-configuration.nix
        
        
        ./modules/boot.nix
        ./modules/users.nix
        ./modules/network.nix
        ./modules/fonts.nix
        ./modules/xserver.nix
        ./modules/packages.nix
        ./modules/local.nix
        ./modules/services.nix
        ./modules/variables.nix
    ];


    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
    
    system.stateVersion = "22.11"; 
}

