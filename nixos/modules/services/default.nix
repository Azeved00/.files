
{

    imports = [
        ./docker.nix
        ./ssh.nix
        ./tailscale.nix
    ];


    systemd.coredump.enable = false;

    services = {
        # Enable CUPS to print documents.
        #printing.enable = true;
        libinput.enable = true;
    };
}
