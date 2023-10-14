{ ... }:
{

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.experimental-features = [ "nix-command flakes" ];
    
    system.stateVersion = "23.05"; 
}

