{ config, pkgs, lib, ...}:
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
                    background = "0x262626";
                    foreground = "0xEBEBEB";
                };
                cursor = {
                    text    ="0xEBEBEB";
                    cursor  ="0xEBEBEB";
                };
                normal = {
                    black   ="0x0d0d0d";
                    red     ="0xFF301B";
                    green   ="0xA0E521";
                    yellow  ="0xFFC620";
                    blue    ="0x1BA6FA";
                    magenta ="0x8763B8";
                    cyan    ="0x21DEEF";
                    white   ="0xEBEBEB";
                };
                bright = {
                    black   ="0x6D7070";
                    red     ="0xFF4352";
                    green   ="0xB8E466";
                    yellow  ="0xFFD750";
                    blue    ="0x1BA6FA";
                    magenta ="0xA578EA";
                    cyan    ="0x73FBF1";
                    white   ="0xFEFEF8";
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
