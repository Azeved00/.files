{ inputs, ... }:
{
    imports = [ inputs.bright-bit.nixosModule ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.experimental-features = [ "nix-command flakes" ];
    
    bright-bit.system.enable = true;

    system.stateVersion = "23.05"; 
}

