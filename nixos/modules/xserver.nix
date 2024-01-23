{ pkgs, lib, config, ...}:
let
    cfg = config.dotfiles.nixos.xserver;
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.xserver = {
        enable = mkEnableOption "enable xserver";
    };

    config = mkIf cfg.enable {
        # Configure keymap in X11
        services.xserver = {
            enable = true;
            autorun = false;
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

    };

}
