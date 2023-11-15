{ config, theme, ...}:
{
programs.rofi =  {
    enable = true;
    cycle = true;
    font = "JetBrainsMono Nerd Font Medium 13";
    location = "center";
    extraConfig = {
        show-icons = true;
        modi = "window,run,drun";

        display-drun= "Applications:";
        drun-display-format= "{icon} {name}";

        display-window= "Windows:";
    };

    theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
    in 
    {
        
        "*" = {
            border  = 0;
            margin  = 0;
            padding = 0;
            spacing = 0;
        };

        "window" =  { width = mkLiteral "50%";};
        
        "element" = {
            padding     = mkLiteral "8 0";
            text-color  = mkLiteral "#${theme.non_text}";
        };

        "element selected" = {
            text-color = mkLiteral "#${theme.white}";
        };

        "element-text" = {
            background-color   = mkLiteral "inherit";
            text-color         = mkLiteral "inherit";
            vertical-align     = mkLiteral "0.5";
        };

        "element-icon" = {
            size = 30;
        };

        "entry" = {
            background-color = mkLiteral "#${theme.white}";
            padding = 12;
            text-color = mkLiteral "#${theme.white}";
        };

        "inputbar" = {
            children = mkLiteral "[prompt, entry]";
        };

        "listview" = {
            padding = mkLiteral "8 12";
            background-color = mkLiteral "#${theme.black}";
            columns = 1;
            lines = 8;
        };

        "mainbox" = {
            background-color = mkLiteral "#${theme.black}";
            children = mkLiteral "[inputbar, listview]";
        };

        "prompt" = {
            background-color = mkLiteral "#${theme.line}";
            enabled = true;
            padding = mkLiteral "12 0 0 12";
            text-color = mkLiteral "#${theme.white}";
        };
    };
};
}
