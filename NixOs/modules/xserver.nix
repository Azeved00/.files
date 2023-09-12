{ pkgs, ...}:
{
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
                theme = "teeny-sddm";
                autoNumlock = true;
            };
            lightdm = {
                enable = false;
                greeters.slick.enable = true;
            };

            defaultSession = "none+default";
            session = [
                {
                    name = "default";
                    manage = "window";
                    start = '' 
                        ${pkgs.runtimeShell} $HOME/.xsession &
                        waitPID=$!
                    '';
                }
                {
                    name = "i3";
                    manage = "window";
                    start = ''
                        
                    '';
                }
            ];
        };
    };
}
