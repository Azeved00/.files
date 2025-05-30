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
        programs.dconf.enable = true;
        
        # Configure keymap in X11
        services.xserver = {
            enable = true;
            autorun = true;
            xkb.layout = cfg.layout;
            desktopManager.xterm.enable = false;
            wacom.enable = true;
            
            displayManager = {
                lightdm.enable = false;
            };

            
            windowManager.i3 = {
                    enable = true;
                    package = pkgs.i3-gaps;
                };
            };

    };

}
