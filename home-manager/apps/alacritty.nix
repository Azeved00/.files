{...}:
let
    colors = {
        black   = "262626";
        red     = "D43542";
        green   = "73A94C";
        yellow  = "ffe11f";
        blue    = "3398EB";
        magenta = "B34BD2";
        cyan    = "0eb8be";
        white   = "F9F6EE";
    };
in
{
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
                    background = "0x${colors.black}";
                    foregroundr= "0x${colors.white}";
                };
                cursor = {
                    text    ="0x${colors.white}";
                    cursor  ="0x${colors.white}";
                };
                normal = {
                    black   ="0x${colors.black}";
                    red     ="0x${colors.red}";
                    green   ="0x${colors.green}";
                    yellow  ="0x${colors.yellow}";
                    blue    ="0x${colors.blue}";
                    magenta ="0x${colors.magenta}";
                    cyan    ="0x${colors.cyan}";
                    white   ="0x${colors.white}";
                };
                bright = {
                    black   ="0x${colors.black}";
                    red     ="0x${colors.red}";
                    green   ="0x${colors.green}";
                    yellow  ="0x${colors.yellow}";
                    blue    ="0x${colors.blue}";
                    magenta ="0x${colors.magenta}";
                    cyan    ="0x${colors.cyan}";
                    white   ="0x${colors.white}";
                };
            };
            
            cursor = {
                style = "Beam";
                blinking = "On";
                blink_interval = 750;
            };

            draw_bold_text_with_bright_colors = true;
            live_config_reload = true;
            #working_directory = "/users/azevedo/";
        };
    };
}
