{config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.alacritty;
in
{
    options.dotfiles.home-manager.alacritty = {
        enable = lib.mkEnableOption "Enable Alacritty module";
        theme = lib.mkOption {
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
                
            type = lib.types.attrs;
        };
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

                font.size = 13.0;

                colors = {
                    primary = {
                        background = "0x${cfg.theme.colors.black}";
                        foreground = "0x${cfg.theme.colors.white}";
                    };
                    cursor = {
                        text    ="0x${cfg.theme.colors.white}";
                        cursor  ="0x${cfg.theme.colors.white}";
                    };
                    normal = {
                        black   ="0x${cfg.theme.colors.black}";
                        red     ="0x${cfg.theme.colors.red}";
                        green   ="0x${cfg.theme.colors.green}";
                        yellow  ="0x${cfg.theme.colors.yellow}";
                        blue    ="0x${cfg.theme.colors.blue}";
                        magenta ="0x${cfg.theme.colors.magenta}";
                        cyan    ="0x${cfg.theme.colors.cyan}";
                        white   ="0x${cfg.theme.colors.white}";
                    };
                    bright = {
                        black   ="0x${cfg.theme.colors.black}";
                        red     ="0x${cfg.theme.colors.red}";
                        green   ="0x${cfg.theme.colors.green}";
                        yellow  ="0x${cfg.theme.colors.yellow}";
                        blue    ="0x${cfg.theme.colors.blue}";
                        magenta ="0x${cfg.theme.colors.magenta}";
                        cyan    ="0x${cfg.theme.colors.cyan}";
                        white   ="0x${cfg.theme.colors.white}";
                    };
                    draw_bold_text_with_bright_colors = true;
                };
                
                cursor = {
                    style = {
                        shape = "Beam";
                        blinking = "On";
                    };
                    blink_interval = 750;
                };

                live_config_reload = true;
                #working_directory = "/users/azevedo/";
            };
        };
    };
}
