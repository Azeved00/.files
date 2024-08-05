{config, lib, pkgs,...}:
let 
    cfg = config.dotfiles.home-manager.i3;
in
{
    imports = [ 
        ./polybar.nix
        ./picom.nix
        ./packages.nix
        ./redshift.nix
    ];

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

        monitor-config =lib.mkOption {
            type = lib.types.str;
            default = "workspace 1 output HDMI-1";
        };
    };


    config = lib.mkIf cfg.enable {
        dotfiles.home-manager= {
            i3.picom.enable = lib.mkDefault true;
            i3.polybar.enable = lib.mkDefault true;
            i3.redshift.enable = lib.mkDefault true;
        };

        services.playerctld.enable = true;

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
                        "1" = [];
                        "2" = [
                            {class="Alacritty";}
                            {class="Develop*";}
                            ];
                        "3" = [];
                        "4" = [
                            {class = "prismlauncher";}
                            {class = "dolphin-emu";}
                            {class = "Minecraft*";}
                            {class = "steam";}
                            {class = "league*";}
                            {class = "live.exe";}
                            {class = "riot*";}
                            {class = "Poke*";}
                            {class = "Heroic*";}
                            {class = "heroic*";}
                        ];
                        "8" = [{class = "explorer.exe"; }];
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

                        "${cfg.mod}+Tab" = ''focus output right'';
                        "${cfg.mod}+Shift+Tab" = ''move workspace to output next'';

                        #"${cfg.mod}+h" = ''split h'';
                        "${cfg.mod}+v" = ''split v'';
                        "${cfg.mod}+f" = ''fullscreen toggle'';
                        "${cfg.mod}+s" = ''layout tabbed'';
                        "${cfg.mod}+Shift+v" = ''layout toggle split'';
                        "${cfg.mod}+Shift+space" = ''floating toggle'';
                        "${cfg.mod}+space" = ''exec --no-startup-id " if [[ $(setxkbmap -query | grep \\"variant\\" | cut -d ':' -f 2) == \\"\\" ]]; then setxkbmap -layout us -variant intl; else setxkbmap -layout us; fi;" '';
                        "${cfg.mod}+a" = ''focus parent'';

                        #audio
                        "F6" = ''exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'';
                        "F7" = ''exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'';
                        "F8" = ''exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'';
                        "XF86AudioMute" = ''exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'';
                        "XF86AudioLowerVolume" = ''exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'';
                        "XF86AudioRaiseVolume" = ''exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'';
                        
                        "F9" = ''exec ${pkgs.playerctl}/bin/playerctl play-pause'';
                        "F10"= ''exec ${pkgs.playerctl}/bin/playerctl previous'';
                        "F11"= ''exec ${pkgs.playerctl}/bin/playerctl next'';

                        #Aplication Shortcuts
                        "${cfg.mod}+b"=''workspace 1; exec firefox'';
                        "${cfg.mod}+t"=''workspace 2; exec alacritty'';
                        "${cfg.mod}+d"=''exec --no-startup-id rofi -show drun'';
                        "${cfg.mod}+Shift+d"=''exec --no-startup-id rofi -show run'';
                        "${cfg.mod}+Shift+s" = ''exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui'';
                        "Print" = ''exec --no-startup-id ${pkgs.flameshot}/bin/flameshot gui'';

                        #i3 shortcuts
                        "${cfg.mod}+Shift+c" = ''reload'';
                        "${cfg.mod}+Shift+r" = ''restart'';
                        "${cfg.mod}+Shift+e" = ''exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"'';

                        #Computer Shortcts
                        "${cfg.mod}+F12"="exec shutdown now";
                    };

                    startup = [
                        (lib.mkIf cfg.polybar.enable {
                            command = "${config.xdg.configHome}/polybar/launch.sh";
                            always = true;
                            notification = false;
                        })
                        (lib.mkIf config.dotfiles.home-manager.eww.enable {
                            command = "${pkgs.eww}/bin/eww close-all && ${pkgs.eww}/bin/eww open bar";
                            always = true;
                            notification = false;
                        })
                        (lib.mkIf cfg.picom.enable {
                            command = "picom --config ${config.xdg.configHome}/picom/picon.conf";
                            always = true;
                            notification = false;
                        })
                        {
                            command = "${pkgs.feh}/bin/feh --no-fehbg --bg-fill ${cfg.background-image}";
                            always = true;
                            notification = false;
                        }
                        {
                            command = "${pkgs.flameshot}/bin/flameshot &";
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
                        {
                            command = "floating disable";
                            criteria = {
                                class = "league*";
                            };
                        }
                        {
                            command = "floating disable";
                            criteria = {
                                class = "riot*";
                            };
                        }
                    ];
                };
                
                extraConfig = cfg.monitor-config;
            };
        };
    };
}
