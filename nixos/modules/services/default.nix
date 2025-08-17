
{

    imports = [
        ./docker.nix
        ./ssh.nix
    ];


    systemd.coredump.enable = false;

    services = {
        # Enable CUPS to print documents.
        printing.enable = true;
        libinput.enable = true;
    };
}
