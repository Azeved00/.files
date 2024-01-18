{config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.i3;
in
{

    options.dotfiles.home-manager.i3 = {
        enable = lib.mkEnableOption "Enable i3 module";

        background-image = lib.mkOption {
            type = lib.types.path;
            default =  ../../../Assets/Pictures/Backgrounds/fractal.png;
        };

        mod = lib.mkOption {
            type = lib.types.str;
            default = "Mod4";
        };

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
        };
    };


    config = lib.mkIf cfg.enable {
        xsession = {
            enable = true;
            numlock.enable = true;

            windowManager.i3 = {
                enable = true;
                config = {
                    modifier = "${cfg.mod}";
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
                        modifier = "${cfg.mod}";
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
                            border = "#${cfg.theme.colors.red}";
                            childBorder = "#900000";
                            indicator = "#900000";
                            text = "#ffffff";
                        };

                        focused = {
                            background = "#285577";
                            border = "#${cfg.theme.colors.yellow}";
                            childBorder = "#${cfg.theme.colors.yellow}";
                            indicator = "#${cfg.theme.colors.yellow}";
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

                        background = "#${cfg.theme.colors.black}";
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
                            {class = "leagueP";}
                            {class = "Poke*";}
                        ];
                    };

                    keybindings = lib.mkOptionDefault {
                        "${cfg.mod}+r" = ''mode "resize"'';
                        
                        # workspace management
                        "${cfg.mod}+1" = ''workspace number "1"'';
                        "${cfg.mod}+2" = ''workspace number "2"'';
                        "${cfg.mod}+3" = ''workspace number "3"'';
                        "${cfg.mod}+4" = ''workspace number "4"'';
                        "${cfg.mod}+5" = ''workspace number "5"'';
                        "${cfg.mod}+6" = ''workspace number "6"'';
                        "${cfg.mod}+7" = ''workspace number "7"'';
                        "${cfg.mod}+8" = ''workspace number "8"'';
                        "${cfg.mod}+9" = ''workspace number "9"'';
                        "${cfg.mod}+0" = ''workspace number "0"'';

                        "${cfg.mod}+Shift+1" = ''move container to workspace number "1"'';
                        "${cfg.mod}+Shift+2" = ''move container to workspace number "2"'';
                        "${cfg.mod}+Shift+3" = ''move container to workspace number "3"'';
                        "${cfg.mod}+Shift+4" = ''move container to workspace number "4"'';
                        "${cfg.mod}+Shift+5" = ''move container to workspace number "5"'';
                        "${cfg.mod}+Shift+6" = ''move container to workspace number "6"'';
                        "${cfg.mod}+Shift+7" = ''move container to workspace number "7"'';
                        "${cfg.mod}+Shift+8" = ''move container to workspace number "8"'';
                        "${cfg.mod}+Shift+9" = ''move container to workspace number "9"'';
                        "${cfg.mod}+Shift+0" = ''move container to workspace number "0"'';

                        #window management
                        "${cfg.mod}+w" = ''kill'';

                        "${cfg.mod}+h" = ''focus left'';
                        "${cfg.mod}+j" = ''focus down'';
                        "${cfg.mod}+k" = ''focus up'';
                        "${cfg.mod}+l" = ''focus right'';

                        "${cfg.mod}+Shift+h" = ''focus left'';
                        "${cfg.mod}+Shift+j" = ''focus down'';
                        "${cfg.mod}+Shift+k" = ''focus up'';
                        "${cfg.mod}+Shift+l" = ''focus right'';

                        "${cfg.mod}+Tab" = ''move workspace to output next'';

                        #"${cfg.mod}+h" = ''split h'';
                        "${cfg.mod}+v" = ''split v'';
                        "${cfg.mod}+f" = ''fullscreen toggle'';
                        "${cfg.mod}+s" = ''layout tabbed'';
                        "${cfg.mod}+Shift+v" = ''layout toggle split'';
                        "${cfg.mod}+Shift+space" = ''floating toggle'';
                        "${cfg.mod}+space" = ''focus mode_toggle'';
                        "${cfg.mod}+a" = ''focus parent'';

                        #audio
                        "F6" = ''exec amixer -q set Master toggle'';
                        "F7" = ''exec amixer -q set Master 5%- unmute'';
                        "F8" = ''exec amixer -q set Master 5%+ unmute'';
                        
                        "F9" = ''exec playerctl play-pause'';
                        "F10"= ''exec playerctl previous'';
                        "F11"= ''exec playerctl next'';

                        #Aplication Shortcuts
                        "${cfg.mod}+b"=''workspace 1; exec firefox'';
                        "${cfg.mod}+t"=''workspace 2; exec alacritty'';
                        "${cfg.mod}+d"=''exec --no-startup-id rofi -show drun'';
                        "${cfg.mod}+Shift+d"=''exec --no-startup-id rofi -show run'';

                        #i3 shortcuts
                        "${cfg.mod}+Shift+c" = ''reload'';
                        "${cfg.mod}+Shift+r" = ''restart'';
                        "${cfg.mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

                        #Computer Shortcts
                        "${cfg.mod}+F12"="exec shutdown now";
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
                            command = "feh --no-fehbg --bg-fill ${cfg.background-image}";
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
    };
}
