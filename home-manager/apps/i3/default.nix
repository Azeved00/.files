{config, lib, theme, ...}:
let 
    background-image = ../../../Assets/Pictures/Backgrounds/fractal.png;
    mod = "Mod4";
in
{
xsession = {
    enable = true;
    numlock.enable = true;

    windowManager.i3 = {
        enable = true;
        config = {
            modifier = "${mod}";
            fonts = {
                names = [ "pango" ];
                style = "monospace";
                size = 15.0;
            };

            terminal = "alacritty";

            gaps.inner = 10;
            gaps.outer = 5;
            window.border = 1;
            window.titlebar = false;
            floating = {
                modifier = "${mod}";
                titlebar = false;
                border = 1;
                
                criteria = [
                    {class="Pavucontrol";}
                    {class="Steam - Update News";}
                ];
            };

            colors = {
                urgent = {
                    background = "#900000";
                    border = "#${theme.colors.red}";
                    childBorder = "#900000";
                    indicator = "#900000";
                    text = "#ffffff";
                };

                focused = {
                    background = "#285577";
                    border = "#${theme.colors.yellow}";
                    childBorder = "#${theme.colors.yellow}";
                    indicator = "#${theme.colors.yellow}";
                    text = "#ffffff";
                };

                unfocused = {
                    background = "#222222";
                    border = "#333333";
                    childBorder = "#222222";
                    indicator = "#292d2e";
                    text = "#888888";
                };
                                
                focusedInactive = {
                    background = "#5f676a";
                    border = "#333333";
                    childBorder = "#5f676a";
                    indicator = "#484e50";
                    text = "#ffffff";
                };

                placeholder = {
                    background = "#0c0c0c";
                    border = "#000000";
                    childBorder = "#0c0c0c";
                    indicator = "#000000";
                    text = "#ffffff";
                };

                background = "#${theme.colors.black}";
            };

            bars = [];
            
            assigns = {
                "1" = [{class="firefox";}];
                "2" = [
                    {class="Alacritty";}
                    {class="Develop*";}
                    ];
                "3" = [];
                "4" = [
                    {class = "prismlauncher";}
                    {class = "dolphin-emu";}
                    {class = "Mnecraft*";}
                    {class = "steam";}
                    {class = "leagueclientux*";}
                    {class = "league*";}
                    {class = "Poke*";}
                    {class = "Heroic";}
                ];
                "8" = [{class = "explorer.exe"; }];
            };

            keybindings = lib.mkOptionDefault {
                "${mod}+r" = ''mode "resize"'';
                
                # workspace management
                "${mod}+1" = ''workspace number "1"'';
                "${mod}+2" = ''workspace number "2"'';
                "${mod}+3" = ''workspace number "3"'';
                "${mod}+4" = ''workspace number "4"'';
                "${mod}+5" = ''workspace number "5"'';
                "${mod}+6" = ''workspace number "6"'';
                "${mod}+7" = ''workspace number "7"'';
                "${mod}+8" = ''workspace number "8"'';
                "${mod}+9" = ''workspace number "9"'';
                "${mod}+0" = ''workspace number "0"'';

                "${mod}+Shift+1" = ''move container to workspace number "1"'';
                "${mod}+Shift+2" = ''move container to workspace number "2"'';
                "${mod}+Shift+3" = ''move container to workspace number "3"'';
                "${mod}+Shift+4" = ''move container to workspace number "4"'';
                "${mod}+Shift+5" = ''move container to workspace number "5"'';
                "${mod}+Shift+6" = ''move container to workspace number "6"'';
                "${mod}+Shift+7" = ''move container to workspace number "7"'';
                "${mod}+Shift+8" = ''move container to workspace number "8"'';
                "${mod}+Shift+9" = ''move container to workspace number "9"'';
                "${mod}+Shift+0" = ''move container to workspace number "0"'';

                #window management
                "${mod}+w" = ''kill'';

                "${mod}+h" = ''focus left'';
                "${mod}+j" = ''focus down'';
                "${mod}+k" = ''focus up'';
                "${mod}+l" = ''focus right'';

                "${mod}+Shift+h" = ''focus left'';
                "${mod}+Shift+j" = ''focus down'';
                "${mod}+Shift+k" = ''focus up'';
                "${mod}+Shift+l" = ''focus right'';

                "${mod}+Tab" = ''move workspace to output next'';

                #"${mod}+h" = ''split h'';
                "${mod}+v" = ''split v'';
                "${mod}+f" = ''fullscreen toggle'';
                "${mod}+s" = ''layout tabbed'';
                "${mod}+Shift+v" = ''layout toggle split'';
                "${mod}+Shift+space" = ''floating toggle'';
                "${mod}+space" = ''focus mode_toggle'';
                "${mod}+a" = ''focus parent'';

                #audio
                "F6" = ''exec amixer -q set Master toggle'';
                "F7" = ''exec amixer -q set Master 5%- unmute'';
                "F8" = ''exec amixer -q set Master 5%+ unmute'';
                
                "F9" = ''exec playerctl play-pause'';
                "F10"= ''exec playerctl previous'';
                "F11"= ''exec playerctl next'';

                #Aplication Shortcuts
                "${mod}+b"=''workspace 1; exec firefox'';
                "${mod}+t"=''workspace 2; exec alacritty'';
                "${mod}+d"=''exec --no-startup-id rofi -show drun'';
                "${mod}+Shift+d"=''exec --no-startup-id rofi -show run'';

                #i3 shortcuts
                "${mod}+Shift+c" = ''reload'';
                "${mod}+Shift+r" = ''restart'';
                "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

                #Computer Shortcts
                "${mod}+F12"="exec shutdown now";
            };

            startup = [
                {
                    command = "${config.xdg.configHome}/polybar/launch.sh";
                    always = true;
                    notification = false;
                }
                {
                    command = "picom --config ${config.xdg.configHome}/picom/picon.conf";
                    always = true;
                    notification = false;
                }
                {
                    command = "feh --no-fehbg --bg-fill ${background-image}";
                    always = true;
                    notification = false;
                }
                {
                    command = "playerctld daemon";
                    always = false;
                    notification = false;
                }
                {
                    command = "xrandr --output HDMI-1 --primary --auto ";
                    always = true;
                    notification = false;
                }
                {
                    command = "xrandr --output DP-3 --auto --right-of HDMI-1";
                    always = true;
                    notification = false;
                }
            ];

            modes = {
                resize = {
                    h = "resize shrink width 10 px or 10 ppt"; 
                    k = "resize grow height 10 px or 10 ppt";
                    j = "resize shrink height 10px or 10 ppt";
                    l = "resize grow width 10 px or 10 ppt";

                    H = "resize shrink width 5 px or 5 ppt"; 
                    K = "resize grow height 5 px or 5 ppt";
                    J = "resize shrink height 5 px or 5 ppt";
                    L = "resize grow width 5 px or 5 ppt";

                    Return = "mode default";
                    Escape = "mode default";
                };
            };
            

            window.commands = [
                {
                    command = "sticky enable";
                    criteria = {
                        title = "Picture-in-Picture";
                    };
                }
            ];
        };
        
        extraConfig = ''
            workspace 6 output DP-3
            workspace 1 output HDMI-1
        '';
    };
};
}
