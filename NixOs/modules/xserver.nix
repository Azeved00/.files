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

            defaultSession = "default";
            session = [
                {
                    name = "default";
                    manage = "desktop";
                    start = '' 
                        ${pkgs.runtimeShell} $HOME/.xsession &
                        waitPID=$!
                    '';
                }
                {
                    name = "i3";
                    manage = "desktop";
                    start = '''';
                }
                {
                    name = "tty";
                    manage = "desktop";
                    start = '''';
                }
            ];
        };
    };
}
