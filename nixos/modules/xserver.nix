{ pkgs, lib, config, ...}:
let
    cfg = config.dotfiles.nixos.xserver;
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.xserver = {
        enable = mkEnableOption "enable xserver";
        layout = mkOption  {
            description = "layout of the keyboard";
            default = "pt";
            type = types.str;

        };

    };

    config = mkIf cfg.enable {
        # Configure keymap in X11
        services.xserver = {
            enable = true;
            autorun = true;
            layout = cfg.layout;
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

    };

}
