{

imports = [
    ./variables.nix
    ./fonts.nix
    ./packages.nix
    ./locale.nix
    ./secrets.nix

    ./desktop
    ./hardware
    ./services
    ./user
];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };
    nix.settings.experimental-features = [ "nix-command flakes" ];
    
    bright-bit.system.enable = true;

    system.stateVersion = "23.05"; 
}

