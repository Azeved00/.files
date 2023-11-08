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
                    background = "0x${theme.colors.background}";
                    foreground = "0x${theme.colors.foreground}";
                };
                cursor = {
                    text    ="0x${theme.colors.white}";
                    cursor  ="0x${theme.colors.white}";
                };
                normal = {
                    black   ="0x${theme.colors.black}";
                    red     ="0x${theme.colors.red}";
                    green   ="0x${theme.colors.green}";
                    yellow  ="0x${theme.colors.yellow}";
                    blue    ="0x${theme.colors.blue}";
                    magenta ="0x${theme.colors.magenta}";
                    cyan    ="0x${theme.colors.cyan}";
                    white   ="0x${theme.colors.white}";
                };
                bright = {
                    black   ="0x${theme.colors.black}";
                    red     ="0x${theme.colors.red}";
                    green   ="0x${theme.colors.green}";
                    yellow  ="0x${theme.colors.yellow}";
                    blue    ="0x${theme.colors.blue}";
                    magenta ="0x${theme.colors.magenta}";
                    cyan    ="0x${theme.colors.cyan}";
                    white   ="0x${theme.colors.white}";
                };
            };
            
            cursor = {
                style = "Beam";
                blinking = "On";
                blink_interval = 750;
            };

            draw_bold_text_with_bright_colors = true;
            live_theme.reload = true;
            #working_directory = "/users/azevedo/";
        };
    };
}
