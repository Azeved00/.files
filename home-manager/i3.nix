{config, lib, ...}:
{
    xsession.windowManager.i3 = {
        enable = true;
        config = {

            modifier = "Mod4";
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
                modifier = "Mod4";
                titlebar = false;
                border = 1;
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
                    {class = "explorer.exe";}
                    {class = "leagueclientux*";}
                    {class = "leagueP";}
                    {class = "Poke*";}
                ];
            };

            keybindings = let 
                mod = config.xsession.windowManager.i3.config.modifier;
            in lib.mkOptionDefault {
                "${mod}+r" = ''mode "resize"'';
                
                # woprkspace management
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

                "${mod}+j" = ''focus left'';
                "${mod}+k" = ''focus down'';
                "${mod}+l" = ''focus up'';
                "${mod}+ccedilla" = ''focus right'';

                "${mod}+Shift+j" = ''focus left'';
                "${mod}+Shift+k" = ''focus down'';
                "${mod}+Shift+l" = ''focus up'';
                "${mod}+Shift+ccedilla" = ''focus right'';


                "${mod}+h" = ''split h'';
                "${mod}+v" = ''split v'';
                "${mod}+f" = ''fullscrieen toggle'';
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
                "${mod}+Shift+d"=''exec --no-startup-id rofi -show run -theme Monokai'';

                #i3 shortcuts
                "${mod}+Shift+c" = ''reload'';
                "${mod}+Shift+r" = ''restart'';
                "${mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

                #Computer Shortcts
                "${mod}+F12"="exec shutdown now";
            };

            startup = [
                {
                    command = "${config.xdg.configHome}/polyvar/launch.sh";
                    always = true;
                    notification = false;
                }
                {
                    command = "picom --config ${config.xdg.configHome}/picom/picon.conf";
                    always = true;
                    notification = false;
                }
                {
                    command = "feh --no-fehbg --bg-fill ${config.home.homeDirectory}/Pictures/Backgrounds/download1.jpeg --bg-fill ${config.home.homeDirectory}/Pictures/Backgrounds/download1.jpeg";
                    always = true;
                    notification = false;
                }
                {
                    command = "playerctld daemon";
                    always = false;
                    notification = false;
                }
                
                {
                    command = "xrandr --output DP-1 --mode 1280x800";
                    always = true;
                    notification = false;
                }
                {
                    command = "xrandr --output HDMI-1 --primary --right-of DP-1 --auto";
                    always = true;
                    notification = false;
                }
            ];

            modes = {
                resize = {
                    j = "resize shrink width 10 px or 10 ppt"; 
                    k = "resize grow height 10 px or 10 ppt";
                    l = "resize shrink height 10px or 10 ppt";
                    ccedilla = "resize grow width 10 px or 10 ppt";

                    Return = "mode default";
                    Escape = "mode default";
                };
            };

        };
        
        extraConfig = ''
            workspace 6 output DP-1
            workspace 1 output HDMI-1
        '';
    };
}
