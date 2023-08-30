{ config, pkgs, lib, ...}:
{
services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;

    shadow = true;
    shadowExclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
        "class_g = 'i3-frame'"
    ];

    fade = true;
    fadeSteps = [0.03 0.03];

    inactiveOpacity = 1;
    opacityRules = [
        "100:name *= 'Picture'"
    ];

    wintypes = {
        tooltip = { 
            fade = true; 
            shadow = true; 
            opacity = 0.75; 
            focus = true; 
            full-shadow = false; 
        };
        dock = { shadow = false; };
        dnd = { shadow = false; };
        popup_menu = { opacity = 0.8; };
        dropdown_menu = { opacity = 0.8; };
    };


    settings = {
        shadow-radius = 7;
        shadow-offset-x = -7;
        shadow-offset-y = -7;
        
        frame-opacity = 0.7;
        inactive-opacity-override = false;
        focus-exclude = ["class_g = 'Cairo-clock'"];

        corner-radius = 0;
        blur-kern = "3x3box";
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];

        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-trasient = true;
        detect-client-leader = true;
        use-damage = true;
        log-level = "warn";
        
    };
};
}
