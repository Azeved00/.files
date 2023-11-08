{theme, ...}:
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
                    background = "0x${theme.background}";
                    foreground = "0x${theme.foreground}";
                };
                cursor = {
                    text    ="0x${theme.white}";
                    cursor  ="0x${theme.white}";
                };
                normal = {
                    black   ="0x${theme.black}";
                    red     ="0x${theme.red}";
                    green   ="0x${theme.green}";
                    yellow  ="0x${theme.yellow}";
                    blue    ="0x${theme.blue}";
                    magenta ="0x${theme.magenta}";
                    cyan    ="0x${theme.cyan}";
                    white   ="0x${theme.white}";
                };
                bright = {
                    black   ="0x${theme.black}";
                    red     ="0x${theme.red}";
                    green   ="0x${theme.green}";
                    yellow  ="0x${theme.yellow}";
                    blue    ="0x${theme.blue}";
                    magenta ="0x${theme.magenta}";
                    cyan    ="0x${theme.cyan}";
                    white   ="0x${theme.white}";
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
