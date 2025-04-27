{...}:
{
    systemd.coredump.enable = false;
    # sound.enable = true;
    hardware.opentabletdriver.enable = false;

    services = {
        pulseaudio.enable = false;

        # Enable the OpenSSH daemon.
        openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no"; 
            PasswordAuthentication = false; 
          };
        };

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
