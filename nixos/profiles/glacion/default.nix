{}:
{

    imports = [ ./hardware.nix ];
    
    dotfiles.nixos.network.name = "glaceon";

    dotfiles.nixos.xserver.enable = "true";
    dotfiles.nixos.xserver.layout = "true";
}
