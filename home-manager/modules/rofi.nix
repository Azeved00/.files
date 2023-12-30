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

        bg0       = mkLiteral "#${theme.colors.black}";
        bg1    = mkLiteral "#${theme.colors.line}";
        accent      = mkLiteral "#${theme.colors.yellow}";
        fg0   = mkLiteral "#${theme.colors.white}";
        fg1   = mkLiteral "#${theme.colors.non-text}";
    in 
    {
        "*" = {
            text-color = fg0;
            background-color = mkLiteral "transparent";

            border  = 0;
            margin  = 0;
            padding = 0;
            spacing = 0;
        };

        "window" =  { 
            location = mkLiteral "center";
            width = mkLiteral "50%";
            border-radius = mkLiteral "24px";

            background-color = bg0;
        };
        
        "element" = {
            padding     = mkLiteral "8px 16px";
            spacing = mkLiteral "8px";
            border-radius = mkLiteral "16px";
        };

        "element normal active" = {
            text-color = accent;
        };

        "element selected normal, element selected active" = {
            background-color = accent;
            text-color = bg0;
        };

        "element-text" = {
            background-color   = mkLiteral "inherit";
            text-color         = mkLiteral "inherit";
            vertical-align     = mkLiteral "0.5";
        };

        "element-icon" = {
            size = 30;
            vertical-align = mkLiteral "0.5";
        };

        "entry" = {
            # background-color = mkLiteral "#${theme.colors.white}";
            # padding = 12;
            text-color = fg0;
        };

        "inputbar" = {
            background-color = bg1;
            border-color = accent;
            text-color = fg0;

            border = mkLiteral "2px";
            border-radius = mkLiteral "16px";

            padding = mkLiteral "8px 16px";
            spacing = mkLiteral "8px";
            children = mkLiteral "[prompt, entry]";
        };

        "listview" = {
            background-color = mkLiteral "transparent";

            margin = mkLiteral "12px 0 0";

            columns = 1;
            lines = 8;
        };

        "mainbox" = {
            padding = mkLiteral "12px";
        };

        "prompt" = {
            enabled = true;
            text-color = fg0;
        };

        "message" = {
            margin = mkLiteral "12px 0 0";
            border-radius = mkLiteral "16px";
            border-color = bg1;
            background-color = bg1;
        };

        "textbox" = {
            padding = mkLiteral "8px 24px";
        };
    };
};
}
