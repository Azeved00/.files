{...}:
{

    imports = [ ../shared.nix ];
     
    dotfiles.nixos.xserver.enable = false;
    dotfiles.nixos.ssh.enable = true;

    networking.host-name = "oldie";
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    system.autoUpgrade.enable = true;

}

