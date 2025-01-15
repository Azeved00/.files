{config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.alacritty;
in
{
    options.dotfiles.home-manager.alacritty = {
        enable = lib.mkEnableOption "Enable Alacritty module";
    };

    config = lib.mkIf cfg.enable {
        programs.alacritty = {
            enable = true;
            
            settings = {
                window = {
                    padding.x = 2;
                    padding.y = 2;
                    opacity   = 1.0;
                    class.instance = "Alacritty";
                    class.general  = "Alacritty";
                };

                scrolling = {
                    history = 10000;
                    multiplier = 3;
                };

                font.size = 12.5;

                cursor = {
                    style = {
                        shape = "Beam";
                        blinking = "On";
                    };
                    blink_interval = 750;
                };

                general.live_config_reload = true;
                #working_directory = "/users/azevedo/";
            };
        };
    };
}
