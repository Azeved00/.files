{lib, config, ...}:
let 
    cfg = config.dotfiles.home-manager.hyprland;
in
with lib;
{

    options.dotfiles.home-manager.hyprland= {
        enable = mkEnableOption "Enable hyprland compositor module";

        background-image = lib.mkOption {
            type = types.path;
            default =  ../../../Assets/Pictures/Backgrounds/fractal.png;
        };

        mod = lib.mkOption {
            type = types.str;
            default = "Mod4";
        };

        theme =mkOption {
            default = {
                colors = {
                    line = "313640";
                    comment = "5c6370";
                    selection = "474e5d";
                    non_text = "919baa";

                    black = "282c34";
                    red = "e06c75";
                    orange = "de935f";
                    yellow = "e5c07b";
                    green = "98c379";
                    cyan = "56b6c2";
                    blue = "61afef";
                    magenta = "c678dd";
                    white = "dcdfe4";
                };
            };
        };
    };
    
    config = mkIf cfg.enable {
        programs.hyprland= {
            enable = true;
            xwayland.enable = true;

            settings = {
                general = {

                };
                

            };

        };

    };


}
