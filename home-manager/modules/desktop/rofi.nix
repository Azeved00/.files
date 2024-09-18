{ config, lib, pkgs,...}:
let 
    cfg = config.dotfiles.home-manager.desktop.rofi;
in
{
    options.dotfiles.home-manager.desktop.rofi= {
        enable = lib.mkEnableOption "Enable Rofi module";
    };


    config = lib.mkIf cfg.enable {
        programs.rofi =  {
            enable = true;
            cycle = true;
            location = "center";
            plugins = [ pkgs.rofi-calc ];
            extraConfig = {
                modi = "window,run,drun,calc";
            };

        };
    };
}
