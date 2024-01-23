{}:
{

    imports = [ ./hardware.nix ];
    
    dotfiles.nixos.network.name = "ovm";
    dotfiles.nixos.xserver.enable = "true";

}
