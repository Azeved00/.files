{pkgs, ...}:
{
    # Configure keymap in X11
    services.xserver = {
        enable = true;
        autorun = true;
        layout = "pt";
        libinput.enable = true;
        desktopManager.xterm.enable = false;
        
        displayManager = {
            lightdm.enable = true;
            defaultSession = "none+i3";
        };
        
        windowManager = {
	        i3.enable = true;
	        i3.package = pkgs.i3-gaps;
        };
    };
}
