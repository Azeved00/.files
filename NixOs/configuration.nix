{ ... }:
{
    imports =
    [ 

        #<home-manager/nixos>
        
        ./modules/boot.nix
        ./modules/users.nix
        ./modules/network.nix
        ./modules/fonts.nix
        ./modules/xserver.nix
        ./modules/packages.nix
        ./modules/local.nix
        ./modules/services.nix
        ./modules/variables.nix
    ] ++ (if builtins.pathExists "/etc/nixos/hardware-configuration.nix" then 
    [
        /etc/nixos/hardware-configuration.nix
    ] 
    else []);


    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.experimental-features = [ "nix-command flakes" ];
    
    system.stateVersion = "23.05"; 
}

