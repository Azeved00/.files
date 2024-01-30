{...}:
{

    imports = [ ./hardware.nix ];
    
    dotfiles.nixos.network.name = "blizzard";

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.xserver.layout = "us";

    dotfiles.nixos.wayland.enable = true;

}
