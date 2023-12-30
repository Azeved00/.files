{ pkgs, inputs, ...}:
{
    imports = [
        inputs.bright-bit.nixosModules.sddm
    ];


    bright-bit.sddm.enable = true;

    # Configure keymap in X11
    services.xserver = {
        enable = true;
        autorun = true;
        layout = "pt";
        libinput.enable = true;
        desktopManager.xterm.enable = false;
        
        displayManager = {
            sddm = {
                enable = true;
                autoNumlock = true;
            };
            lightdm = {
                enable = false;
                greeters.slick.enable = true;
            };

        };
        
	windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
        };
    };
}
