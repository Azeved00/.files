{ pkgs, config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.polybar;
in
{
    options.dotfiles.home-manager.polybar = {
        enable = lib.mkEnableOption "Enable Polybar module";
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
                
            type = lib.types.attrs;
        };
    };

    config = lib.mkIf cfg.enable {
        xdg.configFile."launch.sh" = {
            enable = true;
            executable = true;
            text = ''
                killall -q polybar
                killall -q .polybar-wrapper

                echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
                polybar main 2>&1 | tee -a /tmp/polybar1.log & disown
            '';
            target = "polybar/launch.sh";
        };

        services.polybar = {
            enable = true;
            package = pkgs.polybar.override {
                i3Support = true;
                alsaSupport = true;
                iwSupport = true;
                mpdSupport = true;
                pulseSupport = true;
            };
            
            script = '''';

            settings = {
                "settings" = {
                    screenchange.reload = true;
                    #compositing.background = "xor"; # or screen
                    #compositing.foreground = "source";
                    #compositing.border = "over";
                    pseudo.transparancy = true;
                };

                "global/wm" = {
                    margin.top = 5;
                    margin.bottom = 5;
                };

                "bar/main" = {
                    width = "100%";
                    height = 30;
                    radius = 6.0;
                    fixed.center = true;

                    background = "#${cfg.theme.colors.line}";
                    foreground = "#${cfg.theme.colors.white}";

                    line.size = 3;
                    line.color = "#f00";

                    border.left.size = "1%";
                    border.right.size = "1%";
                    border.top.size = "1%";
                    border.color = "#00000000";

                    padding.left = 0;
                    padding.right = 2;

                    module.margin.left = 1;
                    module.margin.right = 1;


                    font = [
                        "SpaceMono Nerd Font Mono:style=Bold:size=13.5;"
                        "DejaVu Sans Nerd Font Mono:style=Regular;"
                        "JetBrainsMono Nerd Font Mono:style=Regular:pixelsize=13;1"
                    ];

                    modules = {
                        left = "i3 xwindow";
                        center = "date";
                        right = "temperature memory pulseaudio wlan powermenu";
                    };

                    tray.position = "none";
                    tray.padding = 2;

                    cursor.click = "pointer";
                    cursor.scroll = "ns-resize";
                    separator = "|";
                };

                "module/xwindow" = {
                    type = "internal/xwindow";
                    label = "%title:0:30:...%";
                };

                "module/i3" = {
                    type = "internal/i3";
                    format = "<label-state> <label-mode>";
                    index.sort = true;
                    wrapping.scroll = false;

                    ws.icon = [ "1;" "2;" "3;" "4;" "5;5" "6;6" "7;7" "8;8" ];

                    label= {
                        mode = {
                            padding = 2;
                            foreground = "#000";
                            background = "${cfg.theme.colors.yellow}";
                        };

                        focused = {
                            text = "%icon%";
                            background = "${cfg.theme.colors.selection}";
                            underline = "${cfg.theme.colors.yellow}";
                            padding = 2;
                        };

                        unfocused = {
                            text = "%icon%";
                            padding = 2;
                        };

                        visible = {
                            text = "%icon%";
                            background = "\${self.label-focused-background}";
                            underline = "\${self.label-focused-underline}";
                            padding = "\${self.label-focused-padding}";
                        };
                        
                        urgent = {
                            text = "%icon%";
                            background = "${cfg.theme.colors.red}";
                            padding = 2;
                        };
                    };
                };

                "module/memory" = {
                    type = "internal/memory";
                    interval = 2;
                    format.prefix = {
                        text = "";
                        foreground = "${cfg.theme.colors.white}";
                    };
                    label = "%percentage_used%%";
                };

                "module/date" = {
                    type = "internal/date";
                    interval = 5;

                    date.text = "\"  %d-%m-%Y  \"";
                    date.alt = "";

                    time.text = "%H:%M";
                    
                    format.prefix.text = "";
                    format.prefix.foreground = "${cfg.theme.colors.white}";

                    label = "%date% %time%";
                };

                "module/batery" = {
                    type = "internal/battery";
                    battery = "BAT1";
                    adapter = "ACAD";
                    full-at = 98;

                    format = {
                        charging ="<animation-charging> <label-charging>";
                        discharging.text = "<animation-discharging> <label-discharging>";
                        discharging.underline = "\${self.format-charging-underline}";

                        full = {
                            prefix.text = "";
                            prefix.foreground = "${cfg.theme.colors.white}";
                            underline = "\${self.format-charging-underline}";
                        };

                        ramp.capacity.text = [" " "" ""];
                        ramp.capacity.foreground = "${cfg.theme.colors.white}";

                        animation.charging = {
                            text = [" " "" ""];
                            foreground = "${cfg.theme.colors.white}";
                            framerate = 750;
                        };

                        animation.discharging = {
                            text = ["" "" " "];
                            foreground = "${cfg.theme.colors.white}";
                            framerate = 750;
                        };
                    };
                };

                "module/temperature" = {
                    type = "internal/temperature";
                    thermal-zone = 0;
                    hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";

                    interval = 0.5;
                    base-temperature = 20;
                    warn-temperature = 60;

                    format.text = "<ramp> <label>";
                    format.warn = "<ramp> <label-warn>";

                    label.text = "%temperature-c%";
                    label.warn.text = "%temperature-c%";
                    label.warn.foreground = "${cfg.theme.colors.red}";

                    ramp.text = ["" "" ""];
                    ramp.foreground = "${cfg.theme.colors.white}";
                };

                "module/powermenu" = {
                    type = "custom/menu";

                    expand-right = true;

                    label = {
                        open.text="";
                        open.foreground="${cfg.theme.colors.red}";
                        close.text=" cancel";
                        close.foreground="${cfg.theme.colors.red}";
                        separator.text = "|";
                        separator.foreground = "${cfg.theme.colors.red}";
                    };

                    menu = [
                        [
                            {text = "reboot";    exec = "menu-open-1";}
                            {text = "power off"; exec = "menu-open-2";}
                        ] 
                        [
                            {text = "reboot";    exec = "reboot";}
                            {text = "cancel";    exec = "menu-open-0";}
                        ]
                        [
                            {text = "power off"; exec = "poweroff";}
                            {text = "cancel";    exec = "menu-open-0";}
                        ]
                    ];
                };

                "module/pulseaudio" = {
                    type = "internal/pulseaudio";
                    use.ui.max = true;
                    interval = 5;
                    
                    format.volume = "<ramp-volume> <label-volume>";
                    format.muted = "<label-muted>";

                    label.muted.text = " muted";
                    label.muted.foreground = "#66";
                
                    ramp.volume = ["" "" ""];

                    click-right = "pavucontrol &";
                };

                "module/bluetooth" = {
                    type = "custom/script";
                    exec = "$HOME/.config/polybar/scripts/rofi-bluetoth --status";
                    interval = 5;
                    click-left = "$HOME/.config/polybar/scripts/rofi-bluetooth &";
                };

                "module/wlan" = {
                    type = "internal/network";
                    interface = "wlp22s0f0u3";
                    interval = 3.0;
                    
                    format.connected = "%{A1:bash $HOME/.config/polybar/scripts/rofi-wifi-menu.sh &:} <ramp-signal> <label-connected> %{A}";
                    label.connected = "%essid%";

                    format.disconnected = "%{A1:bash $HOME/.config/polybar/scripts/rofi-wifi-menu.sh &:} <label-disconnected> %{A}";
                    label.disconnected.text = "%ifname% disconnected";
                    label.disconnected.foreground = "${cfg.theme.colors.white}";

                    ramp.signal.text = ["" "" "" "" ""];
                    ramp.signal.foreground = "${cfg.theme.colors.white}";
                };
            };
        };
    };
}
