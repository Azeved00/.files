{ ...}:
{
    # Configure keymap in X11
    services.xserver = {
        enable = true;
        autorun = true;
        layout = "pt";
        libinput.enable = true;
        desktopManager.xterm.enable = false;
        
        displayManager = {
            lightdm = {
                enable = true;
                greeters.slick.enable = true;
            };
            ly = {
                enable = true;
                defaultUser = "azevedo";
            };
            defaultSession = "none+i3";
        };
    };
}
