{}:
{

    imports = [ ./hardware.nix ];
    
    dotfiles.nixos.network.name = "quininha";
    dotfiles.nixos.xserver.enable = "true";

}
