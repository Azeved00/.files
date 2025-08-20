{...}:
{

    imports = [ ../shared.nix ];
     
    dotfiles.nixos.xserver.enable = false;
    dotfiles.nixos.ssh.enable = true;
    dotfiles.nixos.docker.enable = true;
    dotfiles.nixos.gui = false;

    networking.hostName = "oldie";
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    system.autoUpgrade.enable = true;

}

