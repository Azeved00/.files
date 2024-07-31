{...}:
{
    systemd.coredump.enable = false;
    # sound.enable = true;
    hardware.pulseaudio.enable = false;
    hardware.opentabletdriver.enable = true;

    # Enable the OpenSSH daemon.
    services = {
        openssh.enable = true;

        # Enable CUPS to print documents.
        printing.enable = true;

        # Enable sound.
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
        };

        libinput.enable = true;
    };
}
